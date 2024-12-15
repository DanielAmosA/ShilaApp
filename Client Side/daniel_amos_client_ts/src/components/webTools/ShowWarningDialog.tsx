import { Container, Image } from "react-bootstrap"
import { dialogActions, kindButtons } from "../../utils/generalVar"
import errorImg from '../../assets/images/error2.gif';
import './ShowWarningDialog.scss'

export const ShowWarningDialog = (title: string, desc: JSX.Element, dialogAction: dialogActions, dialogButtons: kindButtons): JSX.Element => {

    return (
      <div className="dialogCustom">
        <div className="warningDialog">
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
            <Image src={errorImg} alt="errorImg" style={{ width: '8vw', height: '12vh' }} rounded />
          </Container>
        </div>
      </div>
    )
  }