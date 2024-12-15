import { Home, ArrowLeft } from 'lucide-react';
import { Button, Container, Image } from 'react-bootstrap';

import ErrorPic from '../../assets/images/error.gif';
import { useNavigate } from 'react-router-dom';

export const PageNotFound = () => {

  const navigate = useNavigate();

  const handleGoBack = () => {
    window.history.back();
  };

  const handleGoHome = () => {
    navigate('/');
  };

  return (
    <div className="page min-h-screen flex items-center justify-center bg-gray-50">
      <div className="text-center space-y-8 p-8">
        <div className="space-y-4">
          <h1 className="text-9xl font-bold text-gray-900">404</h1>
          <h2 className="text-3xl font-semibold text-gray-700">העמוד לא נמצא אוי</h2>
          <p className="text-gray-500 max-w-md mx-auto">
            איזה רוח טירוווף !
            הגעת לעמוד שלא קיים אלוהי כל השפרות !
          </p>
        </div>

        <div className="flex justify-center gap-4">
          <Button 
            onClick={handleGoBack}
            variant="outline"
            className="flex items-center gap-2"
          >
            <ArrowLeft className="w-4 h-4" />
            חזור לחוף מבטחים
          </Button>
          
          <Button 
            onClick={handleGoHome}
            className="flex items-center gap-2"
          >
            <Home className="w-4 h-4" />
            אין כמו בבית 
          </Button>

          <Container className="text-center">
              <br />
                <Image
                  src={ErrorPic}
                  style={{ width: "8vw", height: "12vh" }}
                  rounded
                />
              </Container>
        </div>

        <div className="mt-8 text-gray-400">
          קוד שגיאה: 404 | Page Not Found
        </div>
      </div>
    </div>
  );
};