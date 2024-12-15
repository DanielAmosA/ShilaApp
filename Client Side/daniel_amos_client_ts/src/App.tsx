import './App.scss';
import audioWeb from "./assets/sounds/Survivor - Eye Of The Tiger (Official HD Video).mp3";
import { createContext, useContext, useEffect, useState } from "react";
import { IAuthContextType } from "./Interfaces/Structure/IAuthContextType";
import { Header } from './components/Header/Header';
import { RenderWebRoutes } from './components/Navigation/RenderNavigation';
import { BrowserRouter } from 'react-router-dom';
import { Footer } from './components/Footer/Footer';
import { GoogleOAuthProvider } from '@react-oauth/google';
import { CallApiGetAction, CallApiPostAction } from './services/apiService';
import { IUserMainDetails } from './Interfaces/Basic/IUserMainDetails';
import { IManagerData } from './Interfaces/Api/IManagerData';
import { ITokenResponse } from './Interfaces/Api/ITokenResponse';


//#region Context

// Creating Default values
const AuthContext = createContext<IAuthContextType>({
  user: null,
  login: async () => {
    return null;
  },
  logout: () => { },
});

// Passing Data Deeply with Context
export const AppAuthData = () => useContext(AuthContext);

//#endregion

export const App = () => {

  //#region  Hook and Members

  // Hook to audio
  const [audio, setAudio] = useState<HTMLAudioElement | null>(null);

  // Hook to user Details
  const [user, setUser] = useState<IUserMainDetails | null>(null);

  //#endregion

  //#region  Methods

  // Play and settings -  Sound to web
  const playSound = () => {
    if (audio) {
      audio.play();
      audio.loop = true;
    }
  };

  useEffect(() => {
    setAudio(new Audio(audioWeb));
  }, []);

  // Get token 
  const GenerateToken = async (managerData: IManagerData): Promise<void> => {

    const roleValue = managerData.isManager ? "Manager" : "Employee";

    const queryParams = new URLSearchParams({
      nameToken: managerData.fullName,
      role: roleValue,
    });


    const res = await CallApiPostAction({
      serviceName: "Auth",
      apiMethod: "GenerateToken",
      params: queryParams,
    });
    const resData = res.data as ITokenResponse;
    if (resData.success) {
      setUser({
        id: managerData.id,
        fullName: managerData.fullName,
        isAuthenticated: managerData.isManager,
        token: resData.token,
      })
    }
    else {
      throw new Error("Token generation failed");
    }
  };

  const login = async (email: string, password: string): Promise<string | null> => {

    // Make a call to the authentication API to check the fullName
    try {

      const queryParams = new URLSearchParams({
        email: email,
        password: password
      });
      const jsonData = await CallApiGetAction({
        serviceName: 'Employee',
        apiMethod: 'SelectByEmailAndPassword',
        params: queryParams
      });

      if (jsonData) {
        if (jsonData.success) {
          const dataSelectByEmailAndPassword: IManagerData[] = jsonData.data as IManagerData[];
          GenerateToken(dataSelectByEmailAndPassword[0]);
          return null;
        }

        else {
          return jsonData.error!;
        }
      }
      return null;

    }

    catch (err) {
      console.log(err, "error");
      return "Login failed: Maybe Server problem ...";
    }
  };


  // Connecting and Disconnecting the user
  // const login = (email: string, password: string): Promise<string> => {

  //   // Make a call to the authentication API to check the fullName
  //   return new Promise((resolve, reject) => {

  //        try {

  //                       const queryParams = new URLSearchParams({
  //                         email: email,
  //                         password: password
  //                     });
  //                     const jsonData = await CallApiGetAction({
  //                         serviceName: 'Employee',
  //                         apiMethod:'SelectByEmailAndPassword',   
  //                         params:queryParams
  //                     });
  //                     const dataSelectByEmailAndPassword = jsonData;
  //                     if(dataSelectByEmailAndPassword.success)
  //                     {
  //                       // const 
  //                       // setUser({fullName});
  //                       // GenerateToken();
  //                       resolve("Success");

  //                         // setShowWarning(true);
  //                         return;
  //                     }
  //                     else{
  //                       reject("Incorrect password");
  //                     }

  //                 }

  //                 catch (err) {
  //                     console.log(err, "error");
  //                     setShowWarning(true);
  //                 }


  //     if (password === "password") {
  //       setUser({ ...user!, fullName: fullName, isAuthenticated: true });
  //       GenerateToken();
  //       resolve("Success");
  //     } else {
  //       reject("Incorrect password");
  //     }
  //   });
  // };

  const logout = (): void => {
    setUser(null);
  };

  //#endregion


  return (
    <div className="App" onClick={() => playSound()}>

      {/* Provider for user */}
      <AuthContext.Provider value={{ user, login, logout }}>
        <GoogleOAuthProvider clientId={import.meta.env.VITE_GOOGLE_CLIENT_ID}>
          <BrowserRouter>
            <Header />
            {/* Main web data */}
            <RenderWebRoutes />
            <Footer />
          </BrowserRouter>
        </GoogleOAuthProvider>
      </AuthContext.Provider>
    </div>
  );
}

