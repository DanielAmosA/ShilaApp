import { Container, Image } from "react-bootstrap"
import { dialogActions, kindButtons } from "../../utils/generalVar"
import successImg from '../../assets/images/success.gif';
import './ShowSuccessDialog.scss'

export const ShowSuccessDialog = (title: string, desc: JSX.Element, dialogAction: dialogActions, dialogButtons: kindButtons): JSX.Element => {

    return (
      <div className="dialogCustom">
        <div className="successDialog">
          <h3 className="titleDialog">{title}</h3>
          <p className="descDialog">{desc} </p>
          {
            dialogButtons === "YesNo" && (
              <>
                <button className="btnDialog" onClick={() => dialogAction("yes")}>Yes</button>
                <button className="btnDialog" onClick={() => dialogAction("no")}>No</button>
              </>
            )
          }
          {
            dialogButtons === "Ok" && (
              <>
                <button className="btnDialog" onClick={() => dialogAction()}>Ok</button>
              </>
            )
          }
  
          <Container className="text-center">
            <Image src={successImg} alt="success Img" style={{ width: '8vw', height: '12vh' }} rounded />
          </Container>
        </div>
      </div>
    )
  }