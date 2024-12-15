import React, {useEffect, useState } from "react";
import {
    Form,
    Button,
    Container,
    Row,
    Col,
    Alert,
    Image,
} from "react-bootstrap";
import SignInPic from "../../assets/images/form.png";
import { useGoogleLogin } from "@react-oauth/google";
import { ValidateDepartment} from "../../utils/validFun";
import { useCreatedDateHandler, useEmailHandler, useFullNameHandler, usePasswordHandler, usePhoneHandler } from "../../utils/useInputHandlers";
import '../../styles/mainForm.scss';
import { CallApiPostAction } from "../../services/apiService";
import { IManagerData } from "../../Interfaces/Api/IManagerData";
import { ShowWarningDialog } from "../../components/webTools/ShowWarningDialog";
import { ShowSuccessDialog } from "../../components/webTools/ShowSuccessDialog";
import { useNavigate } from "react-router-dom";

export const SignUp = () => {

    // #region Hook and Members
    const [maxDate, setMaxDate] = useState<string>("");
    const [department, setDepartment] = useState<string>("");
    const [selectedRole, setSelectedRole] = useState<string>("");

    const [departmentError, setDepartmentError] = useState<string>("");
    const [showPassword, setShowPassword] = useState<boolean>(false);

    const { fullName, fullNameError, HandleFullNameChange } = useFullNameHandler();
    const { email, emailError, HandleEmailChange } = useEmailHandler();
    const { phone, phoneError, HandlePhoneChange } = usePhoneHandler();
    const { createdDateStr, HandleCreatedDateChange } = useCreatedDateHandler();
    const { password, passwordError, confirmPassword, confirmPasswordError, HandlePasswordChange, HandleConfirmPasswordChange} = usePasswordHandler();


    const [showWarning, setShowWarning] = useState<boolean>(false);
    const [msgWarning, setMsgWarning] = useState<string>('');
    const [showSuccess, setShowSuccess] = useState<boolean>(false);
    
    const navigate = useNavigate();

    // #endregion
 
    //#region  Hooks

      // Get current date
      useEffect(() => {
        const now = new Date();
        const formattedDate = now.toISOString().slice(0, 16); // YYYY-MM-DDTHH:MM
        setMaxDate(formattedDate);
        HandleCreatedDateChange(formattedDate,false);
      // eslint-disable-next-line react-hooks/exhaustive-deps
      }, []);

    //#endregion

    //#region Methods

    const HandleDepartmentChange = ( e: React.ChangeEvent<HTMLInputElement> ): void => {
        const value = e.target.value;
        setDepartment(value);
        const error = ValidateDepartment(value);
        setDepartmentError(error);
    };

    //#region Google Section
    // Calling Google APIs registration services.

    const GetUserDetails = (access_token: string): void => {
        const url = new URL('https://www.googleapis.com/oauth2/v3/userinfo');
        url.searchParams.set('access_token', access_token);
        let fullName;
        let email;
        fetch(url)
            .then((response) => response.json())
            .then((resJson) => {
                fullName = resJson.name;
                email = resJson.email;
                HandleFullNameChange(fullName);
                HandleEmailChange(email);
                HandlePasswordChange(email,true);
                HandleConfirmPasswordChange(email,true);
            });
    }

    const SignUpWithGoogle = useGoogleLogin({
        onSuccess: (tokenRes: { access_token: string; }) => {
            GetUserDetails(tokenRes.access_token);
        },
        onError: () => {
            console.log("Sign Up Failed ...");
        }
    })

    // Checking if all the entered data is correct and proceeding to the next step.

    const  HandleSubmit = async (e: React.FormEvent<HTMLFormElement>): Promise<void> => {
        e.preventDefault();

        if (
            fullNameError === "" &&
            emailError === "" &&
            departmentError === "" &&
            passwordError === "" &&
            confirmPasswordError === ""
        ) 
        {
            try {
                    const userData : IManagerData  = {
                        role:selectedRole,
                        department:department,
                        start:new Date(createdDateStr),
                        created:new Date(createdDateStr),
                        fullName: fullName,
                        phone:phone,
                        email: email,
                        password: password
                        
                    };
                const jsonData = await CallApiPostAction({
                    serviceName: 'Manager',
                    apiMethod:'ManagerInsert',   
                    body:userData
                });
                const dataManagerInsert = jsonData;
                if(!dataManagerInsert.success)
                {
                    if(dataManagerInsert.error)
                        setMsgWarning(dataManagerInsert.error!)
                    else
                    setMsgWarning("Oppps Error at create action service");
                    setShowWarning(true);
                    return;
                }
                else{
                    setShowSuccess(true);
                }

            }

            catch (err) {
                console.log(err, "error");
                setShowWarning(true);
            }
        }
    
    };

    // Dialog Action
    const GetUserChoiceOnError = (): void => {
        setShowWarning(false);
      }
      
      const GetUserChoiceOnSuccess = (choice?: string): void => {
        setShowSuccess(false);
        if(choice === "yes")
        {
            navigate("/login");
        }
      }

    // #endregion

    return (
        <div className="page">
            <Container className="mainDetails">
                <Row className="justify-content-md-center">
                    <Col xs={12} md={6}>
                        <h2 className="text-center mt-3 titleForm">
                            ש.ל.ה – ניהול שמניע שינוי בעולם הבריאות !
                        </h2>
                        <Form className="webForm" onSubmit={HandleSubmit}>
                            <Form.Group controlId="formFullName">
                                <Form.Label>שם מלא</Form.Label>
                                <Form.Control
                                    type="text"
                                    placeholder="הכנס שם מלא"
                                    value={fullName}
                                    onChange={(e) => HandleFullNameChange(e.target.value)}
                                    isInvalid={!!fullNameError}
                                    autoComplete="fullName"
                                    required
                                />
                                {fullNameError && (
                                    <Alert variant="danger" className="errorAlertCustom">
                                        {fullNameError}
                                    </Alert>
                                )}
                            </Form.Group>

                            <br />

                            <Form.Group controlId="formEmail">
                                <Form.Label>אימייל</Form.Label>
                                <Form.Control
                                    type="email"
                                    placeholder="הכנס אימייל"
                                    value={email}
                                    onChange={(e) => HandleEmailChange(e.target.value)}
                                    isInvalid={!!emailError}
                                    autoComplete="email"
                                    required
                                />
                                {emailError && (
                                    <Alert variant="danger" className="errorAlertCustom">
                                        {emailError}
                                    </Alert>
                                )}
                            </Form.Group>

                            <Form.Group controlId="formPhone">
                                <Form.Label>פלאפון</Form.Label>
                                <Form.Control
                                    type="text"
                                    placeholder="הכנס פלאפון"
                                    value={phone}
                                    onChange={(e) => HandlePhoneChange(e.target.value)}
                                    isInvalid={!!phoneError}
                                    autoComplete="phone"
                                    required
                                />
                                {phoneError && (
                                    <Alert variant="danger" className="errorAlertCustom">
                                        {phoneError}
                                    </Alert>
                                )}
                            </Form.Group>

                            <br />
                            
                            <Form.Group controlId="formDatetime">
                                <Form.Label>תאריך</Form.Label>
                                <Form.Control
                                    type="datetime-local"
                                    onChange={(e) => HandleCreatedDateChange(e.target.value,false)}
                                    value={createdDateStr}
                                    max={maxDate} 
                                    required
                                />
                            </Form.Group>

                            <br />

                            <Form.Group controlId="formDepartment">
                                <Form.Label>שם מחלקה</Form.Label>
                                <Form.Control
                                    type="text"
                                    placeholder="הכנס שם מחלקה"
                                    value={department}
                                    onChange={HandleDepartmentChange}
                                    isInvalid={!!departmentError}
                                    autoComplete="department"
                                    required
                                />
                                {departmentError && (
                                    <Alert variant="danger" className="errorAlertCustom">
                                        {departmentError}
                                    </Alert>
                                )}
                            </Form.Group>

                            <br />

                            <Form.Group controlId="formRoles">
                                <Form.Label>תפקיד</Form.Label>
                                <Form.Control
                                    as="select"
                                    name="role"
                                    value={selectedRole}
                                    onChange={(e) => setSelectedRole(e.target.value)}
                                    required
                                >

                                    <option value="" disabled>בחר תפקיד</option>
                                    <option value="CEO">CEO (Chief Executive Officer)</option>
                                    <option value="CFO">CFO (Chief Financial Officer)</option>
                                    <option value="CISO">CISO (Chief Information Security Officer)</option>
                                    <option value="CMO">CMO (Chief Marketing Officer)</option>
                                    <option value="Content">Content</option>
                                    <option value="Creative Director">Creative Director</option>
                                    <option value="CTO">CTO (Chief Technology Officer)</option>
                                    <option value="COO">COO (Chief Operating Officer)</option>
                                    <option value="Customer Service">Customer Service</option>
                                    <option value="HR">HR (Human Resources)</option>
                                    <option value="Logistics">Logistics</option>
                                    <option value="Project">Project</option>
                                    <option value="Quality">Quality</option>
                                    <option value="Sales">Sales</option>
                                    <option value="Team Leader">Team Leader</option>
                                </Form.Control>
                            </Form.Group>

                            <br />

                            <Form.Group controlId="formPassword">
                                <Form.Label>סיסמא</Form.Label>
                                <Form.Control
                                    type={showPassword ? "text" : "password"}
                                    placeholder="הכנס סיסמא"
                                    value={password}
                                    onChange={(e) => HandlePasswordChange(e.target.value,false)}
                                    isInvalid={!!passwordError}
                                    autoComplete="current-password"
                                    required
                                />
                                {passwordError && (
                                    <Alert variant="danger" className="errorAlertCustom">
                                        {passwordError}
                                    </Alert>
                                )}
                            </Form.Group>

                            <br />

                            <Form.Group controlId="formConfirmPassword">
                                <Form.Label>אישור סיסמה</Form.Label>
                                <Form.Control
                                    type={showPassword ? "text" : "password"}
                                    placeholder="הכנס שוב את הסיסמה"
                                    value={confirmPassword}
                                    onChange={(e) => HandleConfirmPasswordChange(e.target.value,false)}
                                    isInvalid={!!confirmPasswordError}
                                    autoComplete="current-password"
                                    required
                                />
                                {confirmPasswordError && (
                                    <Alert variant="danger" className="errorAlertCustom">
                                        {confirmPasswordError}
                                    </Alert>
                                )}
                                <Button
                                    type="button"
                                    onClick={() => setShowPassword(!showPassword)}
                                    style={{
                                        background: "none",
                                        border: "none",
                                        cursor: "pointer",
                                    }}
                                    className="w-100 mt-3"
                                >
                                    {showPassword ? "🙈" : "👁️"}
                                </Button>
                            </Form.Group>

                            <Button variant="primary" type="submit" className="w-100 mt-3">
                                הרשם
                            </Button>

                            <Button variant="primary" type="submit" className="w-100 mt-3 btnGoogle"
                            onClick={() => SignUpWithGoogle()}>
                          הרשם עם גוגל 🌟🚀
                        </Button>
                            <Container className="text-center">
                                <br />
                                <Image
                                    src={SignInPic}
                                    style={{ width: "8vw", height: "12vh" }}
                                    rounded
                                />
                            </Container>
                        </Form>
                    </Col>
                </Row>
            </Container>
            {
                showWarning &&
                (
                    ShowWarningDialog("אזהרה ברישום 📛",
                        <>{msgWarning}</>,
                        GetUserChoiceOnError,
                        "Ok"
                    )
                )
            }

           {
                showSuccess &&
                (
                    ShowSuccessDialog("רישום צלח❇️",
                        <>  יאאא פצפצים פיצוצים נרשמת בהצלחה , שנתחיל בשליחות שלנו ?  </>,
                        GetUserChoiceOnSuccess,
                        "YesNo"
                    )
                )
            }
        </div>
    );
};
