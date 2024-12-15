/* eslint-disable @typescript-eslint/no-explicit-any */
import { useEffect, useState } from 'react';
import { Container, Row, Col, Card, Form, Button, Modal } from 'react-bootstrap';
import { Edit2, Trash2, User } from 'lucide-react';
import '../../styles/webAction.scss';
import { useNavigate } from 'react-router-dom';
import { IEmployee } from '../../Interfaces/Entity/IEmployee';
import { ShowKindLoadData } from '../../components/webTools/ShowKindLoadData';
import { CallApiGetAction, CallApiPostAction } from '../../services/apiService';
import { IManagerBasicData } from '../../Interfaces/Api/IManagerBasicData';
import { AppAuthData } from '../../App';
import {typeKindsLoadData } from '../../utils/generalVar';
import { ShowWarningDialog } from '../../components/webTools/ShowWarningDialog';
import { ShowSuccessDialog } from '../../components/webTools/ShowSuccessDialog';


export const SearchEmployee = () => {
    const [searchType, setSearchType] = useState('name');
    const [currentEmployee, setCurrentEmployee] = useState<IEmployee | null>(null);
    

    // for Query Search
    const [fullNameQueryTerm, setFullNameQueryTerm] = useState("");
    const [loadRes, setLoadRes] = useState<boolean>(false);

    // for show info act
    const [kindLoadData, setKindLoadData] = useState<typeKindsLoadData>("Wait");
    const [showWarning, setShowWarning] = useState<boolean>(false);
    const [msgWarning, setMsgWarning] = useState<string>('');
    const [showSuccess, setShowSuccess] = useState<boolean>(false);
    const [showModal, setShowModal] = useState(false);
   
    // for manager search
    const [managers, setManagers] = useState<IManagerBasicData[]>([]);
    const [selectedManager, setSelectedManager] = useState('');
    const [employeeData, setEmployeeData] = useState<IEmployee[]>([]);
    
    const[currentEmployeeDel,setCurrentEmployeeDel] = useState<IEmployee| null>(null);
    const navigate = useNavigate();
    const { user } = AppAuthData();
    const [formData, setFormData] = useState({
        fullName: "",
        phone: "",
        email: "",
        id: 0,
    });


    function debounce(fn: (...args: any[]) => void, delay: number) {
        let timer: ReturnType<typeof setTimeout>;
        return (...args: any[]) => {
          clearTimeout(timer);
          timer = setTimeout(() => fn(...args), delay);
        };
      }

      // Debounce for Search
      const GetEmployeeByContaintsFullName = debounce(async (fullNameQuery: string) => {
        if (!fullNameQuery) return; // We will not search in the case of an empty input.
        setLoadRes(true);
        try {

            setEmployeeData([]);

            const queryParams = new URLSearchParams({
                fullname: fullNameQuery
            });

            const jsonData = await CallApiGetAction(
                {
                    serviceName: 'Employee',
                    apiMethod: 'SelectByContaintsFullName',
                    params: queryParams,
                    token: user?.token
                }
            );


            if (jsonData.success) {
                setEmployeeData(jsonData.data as IEmployee[]);
            }
            else {
                setMsgWarning(jsonData.error!);
                setShowWarning(true);
            }

        } catch (error) {
          console.error("Error fetching employees:", error);
        } finally {
          setLoadRes(false);
        }
      }, 500); // עיכוב של We will debounce a function every 500 milliseconds.
    

    const GetEmployeeByManagerID = async (managerID: string) => {
        try {
            setEmployeeData([]);
            setKindLoadData("Wait");

            const queryParams = new URLSearchParams({
                id: managerID
            });

            const jsonData = await CallApiGetAction(
                {
                    serviceName: 'Manager',
                    apiMethod: 'SelectByManager',
                    params: queryParams,
                    token: user?.token
                }
            );


            if (jsonData.success) {
                console.log(jsonData.data);
                setEmployeeData(jsonData.data as IEmployee[]);
            }
            else {
                setMsgWarning(jsonData.error!);
                setShowWarning(true);
            }

        }
        catch (err) {
            console.log(err, "error");
            setKindLoadData("Error");
        }
    };

  
    useEffect(() => {

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
                else {
                    setMsgWarning(jsonData.error!);
                    setShowWarning(true);
                }

            }
            catch (err) {
                console.log(err, "error");
                setKindLoadData("Error");
            }
        }

        GetManagerData();;
        // On the main load, we will clear the cache and start fresh.
        GetEmployeeByContaintsFullName(fullNameQueryTerm);
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [fullNameQueryTerm])


    const HandleTypeChange = (value: string) => {
        setSelectedManager(value);
        GetEmployeeByManagerID(value);
    }

    
    const HandleEdit = (employee: IEmployee) => {
        setCurrentEmployee(employee);
        setShowModal(true);

        // עדכון ה-state של הטופס
        setFormData({
            fullName: employee?.fullName || "",
            phone: employee?.phone || "",
            email: employee?.email || "",
            id: employee!.id!,
        });
    };

    const HandleDelete = async (employee: IEmployee) => {
        setMsgWarning("אוי בוי ויי אתה בטוח שאתה רוצה למחוק ? את העובד");
        setShowWarning(true);
        setCurrentEmployeeDel(employee)
    };


    // Dialog Action
    const GetUserChoiceOnError = async(choice?: string): Promise<void> => {
        setShowWarning(false);
        if(choice === "yes" && currentEmployeeDel)
        {
            const currentEmployeeDelReq = {
                "original_ID": currentEmployeeDel.id,
                "original_FullName": currentEmployeeDel.fullName,
                "original_Email": currentEmployeeDel.email,
                "original_Phone": currentEmployeeDel.phone,
                "original_Created": currentEmployeeDel.created
            }

            try{
                const jsonData = await CallApiPostAction(
                    {
                        serviceName: 'Employee',
                        apiMethod: 'EmployeeDelete',
                        token: user?.token,
                        body:currentEmployeeDelReq
                    }
                );
        
                console.log(jsonData)
                if (jsonData.success) {
                    setCurrentEmployeeDel(null);
                    setShowSuccess(true);
                }
                else {
                    setMsgWarning(jsonData.error!);
                    setShowWarning(true);
                }

            }
            catch (err) {
                console.log(err, "error");
                setShowWarning(true);
            }
           
        }
      }


      const GoUpdate = async () => {     
        setShowModal(false); 
        try{
            const jsonData = await CallApiPostAction(
                {
                    serviceName: 'Employee',
                    apiMethod: 'EmployeeUpdate',
                    token: user?.token,
                    body:formData
                }
            );

            console.log(jsonData);
    
            if (jsonData.success) {
                setShowSuccess(true);
            }
            else {
                setMsgWarning(jsonData.error!);
                setShowWarning(true);
            }

        }
        catch (err) {
            console.log(err, "error");
            setShowWarning(true);
        }
      }

    const GetUserChoiceOnSuccess = (): void => {
        setShowSuccess(false);
    }

    return (
        <div className='page'>
            <Container className="actionContainer p-4">
                <Card className="actionTopCard">
                    <Card.Body className='actionBody'>
                        <h2 className="actionBodyTitle text-center mb-4">חיפוש עובדים</h2>
                        <Row className="actionBodyRow align-items-end">
                            <Col md={3} className='actionBodyCol'>
                                <Form.Group>
                                    <Form.Label>סוג חיפוש</Form.Label>
                                    <Form.Select
                                        value={searchType}
                                        onChange={(e) => setSearchType(e.target.value)}
                                    >
                                        <option value="name">לפי שם</option>
                                        <option value="manager">לפי מנהל</option>
                                    </Form.Select>
                                </Form.Group>
                            </Col>
                            <Col md={6} className='actionBodyCol'>
                                {searchType === 'name' ? (
                                    <Form.Group>
                                        <Form.Label>חיפוש לפי שם</Form.Label>
                                        <Form.Control
                                            type="text"
                                            placeholder="הקלד שם עובד..."
                                            value={fullNameQueryTerm}
                                            onChange={(e) => setFullNameQueryTerm(e.target.value)}
                                        />
                                        {loadRes && <p>טוען...</p>}
                                    </Form.Group>
                                ) : (
                                    <Form.Group>
                                        <Form.Label>בחר מנהל</Form.Label>
                                        <Form.Select
                                            value={selectedManager}
                                            onChange={(e) => HandleTypeChange(e.target.value)}
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
                                        </Form.Select>
                                    </Form.Group>
                                )}
                            </Col>
                        </Row>
                    </Card.Body>
                </Card>

                <Row className="actionRow mt-4">
                    {
                        employeeData.length > 0
                            ?
                            employeeData.map((employee) => (
                                <Col md={6} lg={4} key={employee.id} className="actionCol mb-4">
                                    <Card className="actionCard">
                                        <Card.Body className='actionCardBody'>
                                            <div className="actionCardBodyHeader">
                                                <div className="actionCardBodyHeaderIcon">
                                                    <User size={24} />
                                                </div>
                                                <div className="actionCardBodyHeaderActions">
                                                    <Button
                                                        variant="light"
                                                        className="btnAction"
                                                        onClick={() => HandleEdit(employee)}
                                                    >
                                                        <Edit2 size={16} />
                                                    </Button>
                                                    <Button
                                                        variant="light"
                                                        className="btnAction"
                                                        onClick={() => HandleDelete(employee)}
                                                    >
                                                        <Trash2 size={16} />
                                                    </Button>
                                                </div>
                                            </div>
                                            <div className='actionCardBodyDetails'>
                                                <h5 className="actionCardBodyDetailsTitle">{employee.fullName}</h5>
                                                <p className='actionCardBodyDetailsDesc'><strong>אימייל:</strong> {employee.email}</p>
                                                <p className='actionCardBodyDetailsDesc'><strong>פלאפון:</strong> {employee.email}</p>
                                                <Button className="actionCardBodyDetailsBtn mx-auto d-block" variant="primary" onClick={() => {
                                                    navigate(`/AddActionToEmployee/${employee.id}`);
                                                }}>
                                                    הוסף פעולה לעובד
                                                </Button>

                                            </div>
                                        </Card.Body>
                                    </Card>
                                </Col>
                            ))
                            :
                            ShowKindLoadData(kindLoadData)
                    }
                </Row>

                {/* Modal for Add/Edit Employee */}
                <Modal className='actionModel' show={showModal} onHide={() => setShowModal(false)} centered dir="rtl">
                    <Modal.Header className='actionModelHeader' closeButton>
                        <Modal.Title>עריכת פרטי עובד</Modal.Title>
                    </Modal.Header>
                    <Modal.Body className='actionModelBody' >
                        <Form>
                            <Form.Group className="mb-3">
                                <Form.Label>שם מלא</Form.Label>
                                <Form.Control
                                    type="text"
                                    defaultValue={currentEmployee?.fullName || ''}
                                    onChange={(e) => setFormData({ ...formData, fullName: e.target.value })}
                                />
                            </Form.Group>
                            <Form.Group className="mb-3">
                                <Form.Label>פלאפון</Form.Label>
                                <Form.Control
                                    type="phone"
                                    defaultValue={currentEmployee?.phone || ''}
                                    onChange={(e) => setFormData({ ...formData, phone: e.target.value })}
                                />
                            </Form.Group>
                            <Form.Group className="mb-3">
                                <Form.Label>אימייל</Form.Label>
                                <Form.Control
                                    type="email"
                                    defaultValue={currentEmployee?.email || ''}
                                    onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                                />
                            </Form.Group>                        
                        </Form>
                    </Modal.Body>
                    <Modal.Footer className='actionModelFooter'>
                        <Button variant="secondary" onClick={() => setShowModal(false)}>
                            ביטול
                        </Button>
                        <Button className='actionModelFooterBtn' variant="primary" onClick={() =>GoUpdate()}>
                            שמור שינויים
                        </Button>
                    </Modal.Footer>
                </Modal>

                {
                    showWarning &&
                    (
                        ShowWarningDialog("אזהרה בפעולה על עובד 📛",
                            <>{msgWarning}</>,
                            GetUserChoiceOnError,
                            "YesNo"
                        )
                    )
                }

                {
                    showSuccess &&
                    (
                        ShowSuccessDialog("ביצוע ביצועיי פעולה צלחה❇️",
                            <>הפעולה בוצעה בהצלחה  זכרו – כי צוות טוב מתחיל באנשים הנכונים. 💙👨‍⚕️</>,
                            GetUserChoiceOnSuccess,
                            "Ok"
                        )
                    )
                }

            </Container>
        </div>

    );
};