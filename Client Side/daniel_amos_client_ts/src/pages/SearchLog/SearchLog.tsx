import { useEffect, useState } from 'react';
import { Container, Row, Col, Card, Form, Button, Modal } from 'react-bootstrap';
import { InfoIcon, User } from 'lucide-react';
import '../../styles/webAction.scss';
import { typeKindsLoadData, typeLog } from '../../utils/generalVar';
import { ILog } from '../../Interfaces/Entity/ILog';
import { ShowKindLoadData } from '../../components/webTools/ShowKindLoadData';
import { CallApiGetAction } from '../../services/apiService';
import { AppAuthData } from '../../App';

// types error to select
const types = [
    { text: "Info", value: 0 },
    { text: "Error", value: 1 }
  ];

export const SearchLog = () => {

    //#region  Hook section

    const [selectedType, setSelectedType] = useState<typeLog>('Info');
    const [showModal, setShowModal] = useState(false);
    const [currentLog, setCurrentLog] = useState<ILog|null>(null);

    const { user } = AppAuthData();

    const [logData, setLogData] = useState<ILog[]>([]);
    const [kindLoadData, setKindLoadData] = useState<typeKindsLoadData>("Wait");

    useEffect(() => {
        GetLogByType('Info')            
          // eslint-disable-next-line react-hooks/exhaustive-deps
          }, []);


    const GetLogByType = async (type: typeLog) => {
        try {
                setLogData([]);
                setKindLoadData("Wait");

                const typeAsNum = type === "Info" ? "0" : "1"

                const queryParams = new URLSearchParams({
                    logType: typeAsNum
                });
        
                const jsonData = await CallApiGetAction(
                  {
                    serviceName:'Manager' ,
                    apiMethod: 'LogSelectByType',
                    params: queryParams,
                    token: user?.token
                  }
                );
        
                
                if(jsonData.success)
                {
                  setLogData(jsonData.data as ILog[]);
                }
        
              }
              catch (err) {
                console.log(err, "error");
                setKindLoadData("Error");
              }
      };

      const HandleInfo = (log : ILog) => {
        setCurrentLog(log);
        setShowModal(true);
    };

    const HandleTypeChange = (value: typeLog) => {
        setSelectedType(value);
        GetLogByType(value);
      };

    //#endregion

    return (
        <div className='page'>
        <Container className="actionContainer p-4">
            <Card className="actionTopCard animate-fade-in">
                <Card.Body className='actionBody'>
                    <h2 className="actionBodyTitle text-center mb-4">חיפוש logs</h2>
                    <Row className="actionBodyRow align-items-end">
                        <Col md={6} className='actionBodyCol'>
                        <Form.Group>
                                    <Form.Label>בחר Log</Form.Label>
                                    <Form.Select
                                        value={selectedType}
                                        onChange={(e) => HandleTypeChange(e.target.value as typeLog)} >
                                        <option value="" disabled>בחר סוג log...</option>
                                        {types.map(type => (
                                            <option key={type.value} value={type.text}>{type.text}</option>
                                        ))}
                                    </Form.Select>
                                </Form.Group>
                        </Col>
                    </Row>
                </Card.Body>
            </Card>

            <Row className="actionRow mt-4">
            {
                logData.length > 0
                ?
                logData.map((log) => (
                    <Col md={6} lg={4} key={log.id} className="actionCol mb-4">
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
                                            onClick={() => HandleInfo(log)}
                                        >
                                            <InfoIcon size={16} />
                                        </Button>
                                    </div>
                                </div>
                                <div className='actionCardBodyDetails'>
                                <h5 className="actionCardBodyDetailsTitle">{log.type}</h5>
                                    <p className='actionCardBodyDetailsDesc'><strong>סוג:</strong> {log.info}</p>
                                </div>
                            </Card.Body>
                        </Card>
                    </Col>
                ))
                :
                 ShowKindLoadData(kindLoadData)
            }
            </Row>

            {/* Modal for Info Log */}
            <Modal className='actionModel' show={showModal} onHide={() => setShowModal(false)} centered dir="rtl">
                <Modal.Header className='actionModelHeader' closeButton>
                    <Modal.Title>תצוגת פרטי Log</Modal.Title>
                </Modal.Header>
                <Modal.Body className='actionModelBody' >
                    <Form>
                        <Form.Group className="mb-3">
                            <Form.Label>סוג</Form.Label>
                            <Form.Control 
                                type="text" 
                                value={currentLog?.type}
                                readOnly 
                            />
                        </Form.Group>
                        <Form.Group className="mb-3">
                            <Form.Label>אודות</Form.Label>
                            <Form.Control 
                                type="text" 
                                value={currentLog?.info || ''}
                                readOnly 
                            />
                        </Form.Group>
                        <Form.Group className="mb-3">
                            <Form.Label>מידע בקשה</Form.Label>
                            <Form.Control 
                                type="text" 
                                defaultValue={currentLog?.requestData || ''}
                                readOnly 
                            />
                        </Form.Group>
                        <Form.Group className="mb-3">
                            <Form.Label>מידע שגיאה</Form.Label>
                            <Form.Control 
                                type="text" 
                                defaultValue={currentLog?.exceptionData || ''}
                                readOnly 
                            />
                        </Form.Group>                     
                    </Form>
                </Modal.Body>
            </Modal>
        </Container>
        </div>
        
    );
};