import { useReducer, useState } from "react";
import { AppAuthData } from "../../App";
import { IUser } from "../../Interfaces/Basic/IUser";
import {
  Alert,
  Button,
  Col,
  Container,
  Form,
  Image,
  Row,
} from "react-bootstrap";
import LogInPic from "../../assets/images/form.png";
import { useGoogleLogin } from "@react-oauth/google";
import '../../styles/mainForm.scss';
import { ShowSuccessDialog } from "../../components/webTools/ShowSuccessDialog";
import { ShowWarningDialog } from "../../components/webTools/ShowWarningDialog";
import { useNavigate } from "react-router-dom";

export const LogIn = () => {

  //#region Hooks section
  const { login } = AppAuthData();

  // Tracking and modifying registration fields simultaneously.
  const [formData, setFormData] = useReducer(
    (formData: IUser, newItem: IUser) => {
      return { ...formData, ...newItem };
    },
    { email: "", password: "" }
  );

  // const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [showPassword, setShowPassword] = useState<boolean>(false);

  const [showWarning, setShowWarning] = useState<boolean>(false);
  const [msgWarning, setMsgWarning] = useState<string>('');
  const [showSuccess, setShowSuccess] = useState<boolean>(false);
  const navigate = useNavigate();

  //#endregion

  const doLogin = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();

    //We will check if a login error was received and act accordingly.
    try {
     const resLogin  =  await login(formData.email, formData.password);
     if(resLogin)
     {
      setMsgWarning(resLogin);
      setShowWarning(true);
     }
     else{
      setShowSuccess(true);
     }
      
    } 
    
    catch (err) {
      const errorString =
        err instanceof Error ? err.message :
          typeof err === "string" ? err : "An unknown error has occurred.";
      setErrorMessage(errorString);
    }
  };

  //#region  Google section
  const getUserDetails = (access_token: string) => {
    const url = new URL("https://www.googleapis.com/oauth2/v3/userinfo");
    url.searchParams.set("access_token", access_token);
    let email;
    fetch(url)
      .then((response) => response.json())
      .then((resJson) => {
        email = resJson.email;
        setFormData({ email: email, password: email });
      });
  };

  const LoginWithGoogle = useGoogleLogin({
    onSuccess: (tokenRes: { access_token: string; }) => {
      getUserDetails(tokenRes.access_token);
    },
    onError: () => {
      console.log("Login Failed ...");
    },
  });
  //#endregion

  //Dialog actions
  const GetUserChoiceOnError = (): void => {
    setShowWarning(false);
  }
  
  const GetUserChoiceOnSuccess = (): void => {
    setShowSuccess(false);
    navigate("/Dashboard");
  }

  return (
    <div className="page">
      <br />
      <Container className="mainDetails">
        <Row className="justify-content-md-center">
          <Col xs={12} md={6}>
            <h2 className="text-center mt-3 titleForm">
              הכללית בשירותך, עם ש.ל.ה שמובילה את הדרך.
            </h2>
            <Form className="webForm" onSubmit={doLogin}>
              <Form.Group controlId="formEmail">
                <Form.Label>אימייל</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="הכנס אימייל"
                  value={formData.email}
                  onChange={(e) =>
                    setFormData({ ...formData, email: e.target.value })
                  }
                  required
                  autoComplete="fullEmail"
                />
              </Form.Group>

              <br />

              <Form.Group controlId="formPassword">
                <Form.Label>סיסמא</Form.Label>
                <Form.Control
                  type={showPassword ? 'text' : 'password'}
                  placeholder="הכנס סיסמא"
                  value={formData.password}
                  onChange={(e) =>
                    setFormData({ ...formData, password: e.target.value })
                  }
                  required
                  autoComplete="current-password"
                />
                <Button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  style={{
                    background: 'none',
                    border: 'none',
                    cursor: 'pointer',
                  }}
                  className="w-100 mt-3"
                >
                  {showPassword ? '🙈' : '👁️'}
                </Button>
              </Form.Group>
              {errorMessage ? (
                <Alert variant="danger" className="errorAlertCustom">
                  {errorMessage}
                </Alert>
              ) : null}

              <Button variant="primary" type="submit" className="w-100 mt-3">
                התחבר
              </Button>

              <Button
                variant="primary"
                type="button"
                className="w-100 mt-3 btnGoogle"
                onClick={() => LoginWithGoogle()}
              >
                התחבר עם גוגל 🌟🚀
              </Button>
              <Container className="text-center">
                <br />
                <Image
                  src={LogInPic}
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
          ShowWarningDialog("אזהרה בהתחברות 📛",
            <>{msgWarning}</>,
            GetUserChoiceOnError,
            "Ok"
          )
        )
      }

      {
        showSuccess &&
        (
          ShowSuccessDialog("התחברות צלחה",
            <>נכנסת פנימה! עכשיו בוא נדאג שהכל יעבוד כמו שעון שוויצרי רפואי. ⏰🩺</>,
            GetUserChoiceOnSuccess,
            "Ok"
          )
        )
      }

    </div>
  );
};
