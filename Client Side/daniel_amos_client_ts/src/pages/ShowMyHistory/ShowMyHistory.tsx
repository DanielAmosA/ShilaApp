import { useEffect, useState } from 'react';
import { Container, Row, Col, Card, Form, Button, Modal } from 'react-bootstrap';
import { InfoIcon, User } from 'lucide-react';
import '../../styles/webAction.scss';
import { AppAuthData } from '../../App';
import { CallApiGetAction } from '../../services/apiService';
import { IHistory } from '../../Interfaces/Entity/IHistory';
import { ShowKindLoadData } from '../../components/webTools/ShowKindLoadData';
import { typeKindsLoadData } from '../../utils/generalVar';
import { formatDateTime } from '../../utils/dateTools';
import { ShowWarningDialog } from '../../components/webTools/ShowWarningDialog';



export const ShowMyHistory = () => {


    //#region  Hook section
    const [showModal, setShowModal] = useState(false);
    const [currentHistory, setCurrentHistory] = useState<IHistory|null>(null);
    const { user } = AppAuthData();
    const [historyData, setHistoryData] = useState<IHistory[]>([]);
    const [kindLoadData, setKindLoadData] = useState<typeKindsLoadData>("Wait");

    const [showWarning, setShowWarning] = useState<boolean>(false);
    const [msgWarning, setMsgWarning] = useState<string>('');

    const HandleInfo = (history : IHistory) => {
        setCurrentHistory(history);
        setShowModal(true);
    };

    // Dialog Action
  const GetUserChoiceOnError = (): void => {
    setShowWarning(false);
  }
  
    useEffect(() => {
    
        const GetHistoryData = async (): Promise<void> => {
    
          try {
    
            setHistoryData([]);
            setKindLoadData("Wait");
    
            const queryParams = new URLSearchParams({
                employeeID: String(user?.id)
            });
    
            const jsonData = await CallApiGetAction(
              {
                serviceName:'Manager' ,
                apiMethod: 'HistorySelectByEmployeeID',
                params: queryParams,
                token: user?.token
              }
            );
    
            
            if(jsonData.success)
            {
              setHistoryData(jsonData.data as IHistory[]);
            }
            else{
                setMsgWarning(jsonData.error!);
                setShowWarning(true);
            }
    
          }
          catch (err) {
            console.log(err, "error");
            setKindLoadData("Error");
          }
        }
          
        GetHistoryData();
      // eslint-disable-next-line react-hooks/exhaustive-deps
      }, []);
     
      //#endregion

    return (
        <div className='page'>
        <Container className="actionContainer p-4">
            
                {
                historyData.length > 0 
                ?
                <Row className="actionRow mt-4">
                {
                 historyData.map((history) => (
                    <Col md={6} lg={4} key={history.id} className="actionCol mb-4">
                        <Card className="actionCard animate-slide-up">
                            <Card.Body className='actionCardBody'>
                                <div className="actionCardBodyHeader">
                                    <div className="actionCardBodyHeaderIcon">
                                        <User size={24} />
                                    </div>
                                    <div className="actionCardBodyHeaderActions">
                                        <Button 
                                            variant="light" 
                                            className="btnAction action-btn"
                                            onClick={() => HandleInfo(history)}
                                        >
                                            <InfoIcon size={16} />
                                        </Button>
                                    </div>
                                </div>
                                <div className='actionCardBodyDetails'>
                                <h5 className="actionCardBodyDetailsTitle">{history.type}</h5>
                                    <p className='actionCardBodyDetailsDesc'><strong>תאריך:</strong> {formatDateTime(history!)}</p>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                ))
            }
                
            </Row>
            :
            ShowKindLoadData(kindLoadData)
        }

            {/* Modal for Info Log */}
            <Modal className='actionModel' show={showModal} onHide={() => setShowModal(false)} centered dir="rtl">
                <Modal.Header className='actionModelHeader' closeButton>
                    <Modal.Title>תצוגת פרטי פעולה</Modal.Title>
                </Modal.Header>
                <Modal.Body className='actionModelBody' >
                    <Form>
                        <Form.Group className="mb-3">
                            <Form.Label>תאריך הפעולה</Form.Label>
                            <Form.Control 
                                type="text" 
                                value={formatDateTime(currentHistory!)}
                                readOnly 
                            />
                        </Form.Group>
                        <Form.Group className="mb-3">
                            <Form.Label>סוג הפעולה</Form.Label>
                            <Form.Control 
                                type="text" 
                                value={currentHistory?.type || ''}
                                readOnly 
                            />
                        </Form.Group>
                        <Form.Group className="mb-3">
                            <Form.Label>תיאור הפעולה</Form.Label>
                            <Form.Control 
                                type="text" 
                                defaultValue={currentHistory?.description || ''}
                                readOnly 
                            />
                        </Form.Group>
                        <Form.Group className="mb-3">
                            <Form.Label>שם מנהל אחראי הפעולה</Form.Label>
                            <Form.Control 
                                type="text" 
                                defaultValue={currentHistory?.managerFullName || ''}
                                readOnly 
                            />
                        </Form.Group>                   
                    </Form>
                </Modal.Body>
            </Modal>
        </Container>
         {
                  showWarning &&
                  (
                    ShowWarningDialog("אזהרה במסע בהיסטוריה .. 📛",
                      <>{msgWarning}</>,
                      GetUserChoiceOnError,
                      "Ok"
                    )
                  )
                }                 
        </div>
        
    );
};