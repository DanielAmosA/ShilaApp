import React from "react";
import { Col, Card } from "react-bootstrap";
import { IManagerDetailsProps } from "../../../Interfaces/Props/IManagerDetails";
import { Mail } from "lucide-react";

export const ManagerDetails: React.FC<IManagerDetailsProps> = ({ role, department, start }) => {
  return (
    <Col xs={12} md={6} lg={6}>
      <Card className="dashboardCard" style={{ animationDelay: "0.2s" }}>
        <Card.Body className="dashboardCardBody">
          <div className="iconWrapper">
            <Mail className="cardIcon" />
          </div>
          <h3 className="cardTitle">פרטי ניהול</h3>
          <div className="cardContent">
            <p><strong>תפקיד נוכחי:</strong> {role}</p>
            <p><strong>מחלקה:</strong> {department}</p>
            <p><strong>תאריך התחלה:</strong> {new Date(start).toLocaleDateString("he-IL")}</p>
          </div>
        </Card.Body>
      </Card>
    </Col>
  );
};

