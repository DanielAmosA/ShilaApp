/* eslint-disable @typescript-eslint/no-explicit-any */
import { useEffect, useState } from "react";
import { Container, Card, Form, Button, Image } from "react-bootstrap";
import {
  User,
  AirplayIcon,
  CalendarPlus2Icon
} from "lucide-react";
import {
  useCreatedDateHandler
} from "../../utils/useInputHandlers";
import AddPic from "../../assets/images/add.png";
import "../../styles/webForm.scss";
import { IAction } from "../../Interfaces/Api/IAction";
import { AppAuthData } from "../../App";
import { ShowKindLoadData } from "../../components/webTools/ShowKindLoadData";
import { typeKindsLoadData } from "../../utils/generalVar";
import { CallApiGetAction, CallApiPostAction } from "../../services/apiService";
import { IHistory } from "../../Interfaces/Entity/IHistory";
import { ShowWarningDialog } from "../../components/webTools/ShowWarningDialog";
import { ShowSuccessDialog } from "../../components/webTools/ShowSuccessDialog";
import { useParams } from "react-router-dom";

export const AddActionToEmployee = () => {

  // #region Hook and Members

  const [minDate, setMinDate] = useState<string>("");
  const [selectedAction, setSelectedAction] = useState<string>("");
  const [actions, setActions] = useState<IAction[]>([]);

  const [kindLoadData, setKindLoadData] = useState<typeKindsLoadData>("Wait");
  const [showWarning, setShowWarning] = useState<boolean>(false);
  const [msgWarning, setMsgWarning] = useState<string>('');
  const [showSuccess, setShowSuccess] = useState<boolean>(false);

  const { createdDateStr, HandleCreatedDateChange } = useCreatedDateHandler();

   const { id } = useParams();
  const { user } = AppAuthData();

  useEffect(() => {

    const GetActionData = async (): Promise<void> => {

      try {

        setActions([]);
        setKindLoadData("Wait");

        const jsonData = await CallApiGetAction(
          {
            serviceName: 'Manager',
            apiMethod: 'ActionSelect',
            token: user?.token
          }
        );


        if (jsonData.success) {
          setActions(jsonData.data as IAction[]);
        }

        else{
          setShowWarning(true);
          setMsgWarning(jsonData.error!);
        }

      }
      catch (err) {
        console.log(err, "error");
        setKindLoadData("Error");
      }
    }

    GetActionData();
    const now = new Date();
    const formattedDate = now.toISOString().slice(0, 16); // YYYY-MM-DDTHH:MM
    setMinDate(formattedDate);
    HandleCreatedDateChange(formattedDate,true);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // #endregion


  const HandleSubmit = async (event: any) => {
    event.preventDefault();
    try {
      const historyData: IHistory = {
        date: new Date(createdDateStr),
        actionID: parseInt(selectedAction),
        employeeID: parseInt(id|| '0'),
        managerEmployeeID: user?.id ? parseInt(user.id.toString()) : 0
      };

      const jsonData = await CallApiPostAction({
        serviceName: 'Manager',
        apiMethod: 'HistoryInsert',
        body: historyData,
        token: user?.token
      });

      const actionInsert = jsonData;
      if (!actionInsert.success) {
        if (actionInsert.error)
          setMsgWarning(actionInsert.error!)
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
          actions.length > 0
            ?
            <Card className="webCard">
              <Card.Body className="webCardBody">
                <div className="titleContainer mb-4">
                  <div className="titleIcon">
                    <User size={32} />
                  </div>
                  <h2 className="titleDesc">הוסף פעולה לעובד 🎢</h2>
                </div>
                <Form onSubmit={HandleSubmit}>
                  <div className="webFormFields">
                    <Form.Group
                      controlId="formAction"
                      className="webFormField"
                    >
                      <div className="webFormFieldIcon">
                        <AirplayIcon size={20} />
                      </div>
                      <Form.Control
                        as="select"
                        name="action"
                        value={selectedAction}
                        onChange={(e) => setSelectedAction(e.target.value)}
                        required
                        className="webFormFieldControl"
                      >
                        <option value="" disabled>
                          בחר פעולה
                        </option>
                        {actions
                          .sort((a, b) => a.type.localeCompare(b.type))
                          .map((action: IAction) => (
                            <option key={action.id} value={action.id} style={{ maxWidth: '400px' }}>
                              {action.type} - {action.description}
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
                        onChange={(e) => HandleCreatedDateChange(e.target.value,true)}
                        value={createdDateStr}
                        min={minDate}
                        required
                        className="webFormFieldControl"
                      />
                    </Form.Group>

                  </div>

                  <Button type="submit" className="btnSubmit">
                    הוסף פעולה לעובד
                  </Button>
                  <Container className="text-center">
                    <br />
                    <Image
                      className="webFormImg"
                      src={AddPic}
                      rounded
                    />
                  </Container>
                </Form>
              </Card.Body>
            </Card>
            :
            ShowKindLoadData(kindLoadData)
        }

        {
          showWarning &&
          (
            ShowWarningDialog("אזהרה בהוספת פעולה 📛",
              <>{msgWarning}</>,
              GetUserChoiceOnError,
              "Ok"
            )
          )
        }

        {
          showSuccess &&
          (
            ShowSuccessDialog("הוספת פעולה צלחה❇️",
              <>המידע נשמר בהצלחה – בריאות מדויקת מתחילה בפרטים הקטנים. 🏥✅</>,
              GetUserChoiceOnSuccess,
              "Ok"
            )
          )
        }

      </Container>

    </div>
  );
};
