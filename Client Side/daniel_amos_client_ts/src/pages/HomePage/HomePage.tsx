import { Container, Row, Col, Button, Card } from "react-bootstrap";
import ClalitAestheticsInPic from "../../assets/images/clalitaesthetics.png";
import ClalitMashlimaInPic from "../../assets/images/clalitmashlima.png";
import ClalitSmilePic from "../../assets/images/clalitsmile.png";
import ShilaWorkVideo from '../../assets/videos/WorkVideo.mp4';

import "./HomePage.scss";

export const HomePage = () => {
    
    return (
        <div className="page">
            <header className="homePageHeader">
                <Container>
                    <div className="infoBox">
                        <h3 className="homePageHeaderTitle">ש.ל.ה. שירותי רפואה</h3>
                        <p className="homePageHeaderDesc">מקבוצת כללית - למען הבריאות שלך</p>
                        <p className="homePageHeaderDesc">
                            מונה כ-170 מרפאות הפרוסות ברחבי הארץ וכ-4500 עובדים ועובדות במגוון תפקידים.
                            <br />
                            <a className="homePageHeaderLink"  href="http://shilajobs.co.il" target="_blank" rel="noopener noreferrer">
                               למשרות החמות ולהגשת קו"ח לחץ/י כאן  
                            </a>
                        </p>
                    </div>
                </Container>
            </header>

            <Container className="servicesSection">
                <Row className="text-center servicesSectionTopRow">
                    <Col className="servicesSectionTopCol">
                        <h2 className="servicesTitle">השירותים שלנו</h2>
                        <p className="servicesDescription">
                            אנו מספקים מגוון רחב של שירותי רפואה איכותיים, מותאמים אישית
                            לצרכים שלך.
                        </p>
                    </Col>
                </Row>

                <Row className="gy-4 servicesSectionContentRow">
                    {[
                        {
                            title: "כללית סמייל",
                            description: "רשת מרפאות שיניים המציעה מגוון טיפולי שיניים",
                            image: ClalitSmilePic,
                            link: "https://www.clalitsmile.co.il/",
                        },
                        {
                            title: "כללית רפואה משלימה",
                            description: "מציעה מגוון רחב של טיפולים משלימים לכל הגילאים. ",
                            image: ClalitMashlimaInPic,
                            link: "https://www.clalitmashlima.co.il/",
                        },
                        {
                            title: "כללית אסתטיקה",
                            description:
                                "רשת מרפאות לרפואה אסתטית המציעה מענה רפואי מקצועי ואיכותי בניתוחים פלסטיים וטיפולים אסתטיים",
                            image: ClalitAestheticsInPic,
                            link: "https://www.clalitaesthetics.co.il/",
                        },
                    ].map((service, index) => (
                        <Col key={index} md={4} className="servicesSectionContentCol">
                            <Card className="serviceCard">
                                <Card.Img
                                    variant="top"
                                    src={service.image}
                                    className="serviceImage"
                                />
                                <Card.Body className="servicesSectionContentBody">
                                    <Card.Title className="serviceTitle">
                                        {service.title}
                                    </Card.Title>
                                    <Card.Text className="serviceDescription">
                                        {service.description}
                                    </Card.Text>
                                    <Button
                                        variant="primary"
                                        className="serviceButton"
                                        onClick={() => window.location.href = service.link}
                                    >
                                        לפרטים נוספים
                                    </Button>
                                </Card.Body>
                            </Card>
                        </Col>
                    ))}
                </Row>
                <Row className="gy-6 videoContainerRow">
                    <div className="videoContainer">
                        <video controls className="serviceVideo">
                            <source src={ShilaWorkVideo} type="video/mp4" />
                            הדפדפן שלך לא תומך בסרטונים.
                        </video>
                    </div>
                </Row>
            </Container>
        </div>
    );
};
