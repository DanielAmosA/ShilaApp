import { Col, Container, Image, Row } from "react-bootstrap"
import { typeKindsLoadData } from "../../utils/generalVar"
import waitImg from '../../assets/images/loading.png';
import waitImg2 from '../../assets/images/loading2.png';
import errorLoadImg from '../../assets/images/error3.png';
import './ShowKindLoadData.scss'

// Displaying an details about the data being loaded / received / failed
export const ShowKindLoadData = (kind: typeKindsLoadData): JSX.Element => {
    if (kind === "Wait") {
      return (
        <Container className="text-center mainKindLoadData">
          <Row className="justify-content-md-center">
            <Col xs={12} md={6}>
              <p className='mainKindLoadDataTitle'>"כמו מד חום דיגיטלי – לוקח שניות, אבל מדייקים בשבילך! 🌡️✨" </p>
              <Image className='mainKindLoadDataImg' src={waitImg} alt="waitImg" rounded />
            </Col>
          </Row>
        </Container>
      )
    }
    else if (kind === "Error") {
      return (
        <Container className="text-center mainKindLoadData">
          <Row className="justify-content-md-center">
            <Col xs={12} md={6}>
              <p className='mainKindLoadDataTitle'>המידע לא נמצא... אולי הוא יצא לחופשת מחלה? 🤒 נסה שוב בעוד רגע!"</p>
              <Image className='mainKindLoadDataImg' src={errorLoadImg} alt="errorLoadImg" rounded />
            </Col>
          </Row>
        </Container>
      )
    }
  
    else {
      return (
        <Container className="text-center mainKindLoadData">
          <Row className="justify-content-md-center">
            <Col xs={12} md={6}>
              <p className='mainKindLoadDataTitle'>"אופס... לא הצלחנו למצוא את מה שחיפשת, אבל אנחנו תמיד כאן כדי לעזור! 🩹💡"</p>
              <Image className='mainKindLoadDataImg' src={waitImg2} alt="waitImg" rounded />
            </Col>
          </Row>
        </Container>
      )
    }
  
  }
  