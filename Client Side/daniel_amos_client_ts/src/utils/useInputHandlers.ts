import { useState } from "react";
import { ValidateConfirmPassword, ValidateEmail, ValidateFullName, ValidatePassword, ValidatePhone } from "./validFun";

// A function to Handle a full name.
export const useFullNameHandler = () => {
  const [fullName, setFullName] = useState<string>("");
  const [fullNameError, setFullNameError] = useState<string>("");

  const HandleFullNameChange = (value: string) => {
    setFullName(value);
    const error = ValidateFullName(value);
    setFullNameError(error);
  };

  return { fullName, fullNameError, HandleFullNameChange };
};

// A function to Handle a email.
export const useEmailHandler = () => {
  const [email, setEmail] = useState<string>("");
  const [emailError, setEmailError] = useState<string>("");

  const HandleEmailChange = (value: string) => {
    setEmail(value);
    const error = ValidateEmail(value);
    setEmailError(error);
  };

  return { email, emailError, HandleEmailChange };
};

// A function to Handle a phone.
export const usePhoneHandler = () => {
  const [phone, setPhone] = useState<string>("");
  const [phoneError, setPhoneError] = useState<string>("");

  //Filter out non-numeric characters and limit input to 10 characters while typing.
  const HandlePhoneChange = (value: string) => {
    const sanitizedValue = value.replace(/[^0-9]/g, ""); 
    if (sanitizedValue.length <= 10) {
      setPhone(sanitizedValue);
    }
    const error = ValidatePhone(sanitizedValue);
    setPhoneError(error);
  };

  return { phone, phoneError, HandlePhoneChange };
};

// A function to Handle a phone.
export const useCreatedDateHandler = () => {
    const [createdDateStr, setCreatedDateStr] = useState<string>("");
  
    const HandleCreatedDateChange = (value: string, isFromCurrent:boolean  ) => {
        const now = new Date();
        const selectedTime = new Date(value);

        // We will check if we want up to the current date and time or from it, 
        // and then act accordingly.
        if(isFromCurrent)
        {
          if (selectedTime > now) {
            setCreatedDateStr(value);
          }
        }

        if(!isFromCurrent)
          {
            if (selectedTime < now) {
              setCreatedDateStr(value);
            } else {
              alert("לא ניתן לבחור שעות מאוחרות יותר מהנוכחיות היום.");
            }
          }
        
    };
  
    return { createdDateStr, HandleCreatedDateChange };
  };


  // A function to Handle a password and confirmPassword.
export const usePasswordHandler = () => {
    const [password, setPassword] = useState<string>("");
    const [passwordError, setPasswordError] = useState<string>("");
    const [confirmPassword, setConfirmPassword] = useState<string>("");
    const [confirmPasswordError, setConfirmPasswordError] = useState<string>("");
  
    //Limit input to 20 characters while typing.
    const HandlePasswordChange = (value: string , isGooglePassword:boolean) => {

      // First, we will check if Google provided the password (the unique email), and therefore there is no need to verify.
      if(isGooglePassword)
      {
        setPassword(value);
      }
      else{
        if (value.length <= 20) {
            setPassword(value);
          }
    
          const err = ValidatePassword(value);
          setPasswordError(err);
      }

    }

      const HandleConfirmPasswordChange = (value: string, isGooglePassword:boolean) => {
        setConfirmPassword(value);
        if(!isGooglePassword)
            {
                const err = ValidateConfirmPassword(password, value);
                setConfirmPasswordError(err);
            }
        
      };
  
    return { password, passwordError, confirmPassword,  confirmPasswordError, HandlePasswordChange, HandleConfirmPasswordChange };
  };