import React from "react";
import { Col, Card } from "react-bootstrap";
import { User } from "lucide-react";
import { IPersonalDetails } from "../../../Interfaces/Props/IPersonalDetails";

export const PersonalDetails: React.FC<IPersonalDetails> = ({ fullName, email, phone, created, managerFullName}) => {
  return (
    <Col xs={12} md={6} lg={6}>
      <Card className="dashboardCard animate-slide-up">
        <Card.Body className="dashboardCardBody">
          <div className="iconWrapper">
            <User className="cardIcon" />
          </div>
          <h3 className="cardTitle">פרטים אישיים</h3>
          <div className="cardContent">
            <p><strong>שם מלא:</strong> {fullName}</p>
            <p><strong>אימייל:</strong> {email}</p>
            <p><strong>פלאפון:</strong> {phone}</p>
            <p><strong>תאריך התחלה:</strong> {new Date(created).toLocaleDateString("he-IL")}</p>
            {managerFullName !== null 
            &&
              <p><strong>שם מנהל:</strong> {managerFullName}</p>       
            }
            
          </div>
        </Card.Body>
      </Card>
    </Col>
  );
}
