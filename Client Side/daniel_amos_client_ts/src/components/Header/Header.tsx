import { Card } from 'react-bootstrap';
import headerImg from "../../assets/images/header.png";
import "./Header.scss"
import { RenderWebMenu } from '../Navigation/RenderNavigation';

// The footer frame of the website.
export const Header = () => {
    return (
        <Card className="text-center">
            <Card.Header>
                <Card.Title className="rainbowText"  >
                    ש.ל.ה
                </Card.Title>
            </Card.Header>
            <Card.Body>
                <Card.Img
                    variant="top"
                    src={headerImg}
                    alt="header Img"
                    className='cardImg'
                />
                <Card.Text>
                👨‍⚕️ מנהיגות וחדשנות ^  מייצרים את העתיד הרפואי של היום 👩‍⚕️
                </Card.Text>
            </Card.Body>

            {/* Main web menu */}
            <Card.Footer>
                <RenderWebMenu/>
            </Card.Footer>
        </Card>
    )
}

