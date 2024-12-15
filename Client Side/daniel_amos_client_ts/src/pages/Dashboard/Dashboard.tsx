import { Container, Image, Row } from "react-bootstrap";
import { PersonalDetails } from "./components/PersonalDetails";
import { useEffect, useState } from "react";
import { ManagerDetails } from "./components/ManagerDetails";
import DashboardPic from "../../assets/images/dashboard.gif";
import './Dashboard.scss';
import { AppAuthData } from "../../App";
import { IManagerData } from "../../Interfaces/Api/IManagerData";
import { typeKindsLoadData } from "../../utils/generalVar";
import { CallApiGetAction } from "../../services/apiService";
import { ShowKindLoadData } from "../../components/webTools/ShowKindLoadData";


const motivationalQuotes = [
  "מנהיגות היא היכולת להפוך חזון למציאות",
  "הצלחה היא לא המפתח לאושר. אושר הוא המפתח להצלחה",
  "כל הישג מתחיל בהחלטה לנסות",
  "מנהיג טוב לוקח קצת יותר מהאשמה ומעט פחות מהקרדיט",
  "הדרך הטובה ביותר לנבא את העתיד היא ליצור אותו"
];

const Dashboard = () => {

  const [quote, setQuote] = useState<string>('');
  const { user } = AppAuthData();
  const [managerEmployeeData, setManagerEmployeeData] = useState<IManagerData[]>([]);
  const [kindLoadData, setKindLoadData] = useState<typeKindsLoadData>("Wait");

  useEffect(() => {

    const GetManagerEmployeeData = async (): Promise<void> => {

      try {

        setManagerEmployeeData([]);
        setKindLoadData("Wait");

        const queryParams = new URLSearchParams({
          id: String(user?.id)
        });

        const jsonData = await CallApiGetAction(
          {
            serviceName: 'Manager',
            apiMethod: 'ManagerFullDataSelectByID',
            params: queryParams,
            token: user?.token
          }
        );
        
        if(jsonData.success)
        {
          setManagerEmployeeData(jsonData.data as IManagerData[]);
        }

      }
      catch (err) {
        console.log(err, "error");
        setKindLoadData("Error");
      }
    }
    // Selecting a random quote on component load.
    const randomQuote = motivationalQuotes[Math.floor(Math.random() * motivationalQuotes.length)];
    setQuote(randomQuote);

    // Switching the quote every 10 seconds.
    const interval = setInterval(() => {
      const newQuote = motivationalQuotes[Math.floor(Math.random() * motivationalQuotes.length)];
      setQuote(newQuote);
    }, 10000);

    GetManagerEmployeeData();
    return () => clearInterval(interval);
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);



  return (
    <div className="page">
      <Container className="dashboardContent p-4">
        <div className="quoteSection mb-4 text-center">
          <h2 className="quoteText">"{quote}"</h2>
        </div>
        {
          managerEmployeeData.length > 0 ?
        <Row className="g-4">
          <PersonalDetails
            fullName={managerEmployeeData[0].fullName}
            email={managerEmployeeData[0].email}
            phone={managerEmployeeData[0].phone}
            created={managerEmployeeData[0].created.toString()}
            managerFullName={managerEmployeeData[0].managerFullName}
          />
          {user?.isAuthenticated &&
            (
              <ManagerDetails
                role={managerEmployeeData[0].role}
                department={managerEmployeeData[0].department}
                start={managerEmployeeData[0].start.toString()}
              />
            )}

        </Row>
        :
        ShowKindLoadData(kindLoadData)
       }
      </Container>
      <Container className="text-center">
        <br />
        <Image
          src={DashboardPic}
          style={{ width: "20vw", height: "22vh" }}
          rounded
        />
      </Container>
    </div>

  );
};

export default Dashboard;
