import { useEffect, useState } from "react";
import { Container, Card, Form, Button, Image } from "react-bootstrap";
import {
  User,
  Mail,
  LucideIceCream,
  CalendarPlus2Icon,
  LockIcon,
  Phone,
  LockKeyholeIcon,
} from "lucide-react";
import {
  useCreatedDateHandler,
  useEmailHandler,
  useFullNameHandler,
  usePasswordHandler,
  usePhoneHandler,
} from "../../utils/useInputHandlers";
import { IManagerBasicData } from "../../Interfaces/Api/IManagerBasicData";
import CreatePic from "../../assets/images/create.gif";
import "../../styles/webForm.scss";
import { ShowKindLoadData } from "../../components/webTools/ShowKindLoadData";
import { CallApiGetAction, CallApiPostAction } from "../../services/apiService";
import { AppAuthData } from "../../App";
import { IEmployee } from "../../Interfaces/Entity/IEmployee";
import { ShowWarningDialog } from "../../components/webTools/ShowWarningDialog";
import { ShowSuccessDialog } from "../../components/webTools/ShowSuccessDialog";
import { typeKindsLoadData } from "../../utils/generalVar";

export const CreateNewEmployee = () => {
  // #region Hook and Members

  const [maxDate, setMaxDate] = useState<string>("");
  const [selectedManager, setSelectedManager] = useState<string>("");
  const [managers, setManagers] = useState<IManagerBasicData[]>([]);

  const [showPassword, setShowPassword] = useState<boolean>(false);

  const { fullName, fullNameError, HandleFullNameChange } = useFullNameHandler();
  const { email, emailError, HandleEmailChange } = useEmailHandler();
  const { phone, phoneError, HandlePhoneChange } = usePhoneHandler();
  const { createdDateStr, HandleCreatedDateChange } = useCreatedDateHandler();

  const [kindLoadData, setKindLoadData] = useState<typeKindsLoadData>("Wait");
  const [showWarning, setShowWarning] = useState<boolean>(false);
  const [msgWarning, setMsgWarning] = useState<string>('');
  const [showSuccess, setShowSuccess] = useState<boolean>(false);

  const {
    password,
    passwordError,
    confirmPassword,
    confirmPasswordError,
    HandlePasswordChange,
    HandleConfirmPasswordChange,
  } = usePasswordHandler();

  // #endregion

  const { user } = AppAuthData();

  useEffect(() => {

    // Retrieving the managers currently in the system.
    const GetManagerData = async (): Promise<void> => {

      try {

        setManagers([]);
        setKindLoadData("Wait");

        const jsonData = await CallApiGetAction(
          {
            serviceName: 'Manager',
            apiMethod: 'ManagerSelect',
            token: user?.token
          }
        );


        if (jsonData.success) {
          setManagers(jsonData.data as IManagerBasicData[]);
        }

      }
      catch (err) {
        console.log(err, "error");
        setKindLoadData("Error");
      }
    }

    GetManagerData();
    const now = new Date();
    const formattedDate = now.toISOString().slice(0, 16); // YYYY-MM-DDTHH:MM
    setMaxDate(formattedDate);
    HandleCreatedDateChange(formattedDate,false);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Checking if all the entered data is correct and proceeding to the next step.

  const HandleSubmit = async (e: React.FormEvent<HTMLFormElement>): Promise<void> => {
    e.preventDefault();

    if (
      fullNameError === "" &&
      emailError === "" &&
      passwordError === "" &&
      confirmPasswordError === ""
    ) {
      try {

        const employeeData: IEmployee = {
          fullName: fullName,
          phone: phone,
          email: email,
          password: password,
          created: new Date(createdDateStr),
          managerID:selectedManager ? parseInt(selectedManager) : undefined
        };


        const jsonData = await CallApiPostAction({
          serviceName: 'Employee',
          apiMethod: 'EmployeeInsert',
          body: employeeData,
          token:user?.token
        });
        const dataManagerInsert = jsonData;
        if (!dataManagerInsert.success) {
          if (dataManagerInsert.error)
            setMsgWarning(dataManagerInsert.error!)
          else
            setMsgWarning("Oppps Error at create action service");
          setShowWarning(true);
          return;
        }
        else {
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
  
    const GetUserChoiceOnSuccess = (): void => {
      setShowSuccess(false);
      }

  return (
    <div className="page">
      <Container className="webContainer py-5">
        {
          managers.length > 0
            ?

            <Card className="webCard">
              <Card.Body className="webCardBody">
                <div className="titleContainer mb-4">
                  <div className="titleIcon">
                    <User size={32} />
                  </div>
                  <h2 className="titleDesc">צור עובד חדש 🏰</h2>
                </div>
                <Form onSubmit={HandleSubmit}>
                  <div className="webFormFields">
                    <Form.Group
                      controlId="formFullName"
                      className="webFormField">
                      <div className="webFormFieldIcon">
                        <User size={20} />
                      </div>
                      <Form.Control
                        type="text"
                        placeholder="הכנס שם מלא"
                        value={fullName}
                        onChange={(e) => HandleFullNameChange(e.target.value)}
                        isInvalid={!!fullNameError}
                        autoComplete="fullName"
                        required
                        className="webFormFieldControl"
                      />
                      <Form.Control.Feedback type="invalid">
                        {fullNameError}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group
                      controlId="formEmail"
                      className="webFormField"
                    >
                      <div className="webFormFieldIcon">
                        <Mail size={20} />
                      </div>
                      <Form.Control
                        type="email"
                        placeholder="הכנס אימייל"
                        value={email}
                        onChange={(e) => HandleEmailChange(e.target.value)}
                        isInvalid={!!emailError}
                        autoComplete="email"
                        required
                        className="webFormFieldControl"
                      />
                      <Form.Control.Feedback type="invalid">
                        {emailError}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group
                      controlId="formPhone"
                      className="webFormField"
                    >
                      <div className="webFormFieldIcon">
                        <Phone size={20} />
                      </div>
                      <Form.Control
                        type="text"
                        placeholder="הכנס פלאפון"
                        value={phone}
                        onChange={(e) => HandlePhoneChange(e.target.value)}
                        isInvalid={!!phoneError}
                        autoComplete="phone"
                        required
                        className="webFormFieldControl"
                      />
                      <Form.Control.Feedback type="invalid">
                        {phoneError}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group
                      controlId="formManager"
                      className="webFormField"
                    >
                      <div className="webFormFieldIcon">
                        <LucideIceCream size={20} />
                      </div>
                      <Form.Control
                        as="select"
                        name="manager"
                        value={selectedManager}
                        onChange={(e) => setSelectedManager(e.target.value)}
                        required
                        className="webFormFieldControl"
                      >
                        <option value="" disabled>
                          בחר מנהל
                        </option>
                        {managers
                          .sort((a, b) => a.employeeName.localeCompare(b.employeeName))
                          .map((manager: IManagerBasicData) => (
                            <option key={manager.id} value={manager.id}>
                              {manager.employeeName} ⚽️ {manager.role} 🥏 {manager.department}
                            </option>
                          ))}
                      </Form.Control>
                    </Form.Group>

                    <Form.Group
                      controlId="formCreatedDate"
                      className="webFormField"
                    >
                      <div className="webFormFieldIcon">
                        <CalendarPlus2Icon size={20} />
                      </div>
                      <Form.Control
                        type="datetime-local"
                        onChange={(e) => HandleCreatedDateChange(e.target.value,false)}
                        value={createdDateStr}
                        max={maxDate}
                        required
                        className="webFormFieldControl"
                      />
                    </Form.Group>

                    <Form.Group
                      controlId="formPassword"
                      className="webFormField"
                    >
                      <div className="webFormFieldIcon">
                        <LockIcon size={20} />
                      </div>
                      <Form.Control
                        type={showPassword ? "text" : "password"}
                        placeholder="הכנס סיסמא"
                        value={password}
                        onChange={(e) =>
                          HandlePasswordChange(e.target.value, false)
                        }
                        isInvalid={!!passwordError}
                        autoComplete="current-password"
                        required
                        className="webFormFieldControl"
                      />
                      <Form.Control.Feedback type="invalid">
                        {passwordError}
                      </Form.Control.Feedback>
                    </Form.Group>

                    <Form.Group
                      controlId="formConfirmPassword"
                      className="webFormField"
                    >
                      <div className="webFormFieldIcon">
                        <LockKeyholeIcon size={20} />
                      </div>
                      <Form.Control
                        type={showPassword ? "text" : "password"}
                        placeholder="הכנס שוב את הסיסמה"
                        value={confirmPassword}
                        onChange={(e) =>
                          HandleConfirmPasswordChange(e.target.value, false)
                        }
                        isInvalid={!!confirmPasswordError}
                        autoComplete="current-password"
                        required
                        className="webFormFieldControl"
                      />
                      <Form.Control.Feedback type="invalid">
                        {confirmPasswordError}
                      </Form.Control.Feedback>
                    </Form.Group>
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
                  </div>

                  <Button type="submit" className="btnSubmit">
                    צור עובד
                  </Button>
                  <Container className="text-center">
                    <br />
                    <Image
                      className="webFormImg"
                      src={CreatePic}
                      rounded
                    />
                  </Container>
                </Form>
              </Card.Body>
            </Card>
            :
            ShowKindLoadData(kindLoadData)
        }
      </Container>
      {
        showWarning &&
        (
          ShowWarningDialog("אזהרה ביצירת עובד 📛",
            <>{msgWarning}</>,
            GetUserChoiceOnError,
            "Ok"
          )
        )
      }

      {
        showSuccess &&
        (
          ShowSuccessDialog("יצירת עובד צלחה❇️",
            <>העובד החדש הוזן במערכת – ברוכים הבאים לצוות המנצח! 🌟💼</>,
            GetUserChoiceOnSuccess,
            "Ok"
          )
        )
      }
    </div>
  );
};
