import { INavigationPart } from '../../Interfaces/Structure/INavigationPart';
import { LogIn } from '../../pages/LogIn/LogIn';
import { SignUp } from '../../pages/SignUp/SignUp';
import { HomePage } from '../../pages/HomePage/HomePage';
import Dashboard from '../../pages/Dashboard/Dashboard';
import { CreateNewEmployee } from '../../pages/CreateNewEmployee/CreateNewEmployee';
import { CreateNewAction } from '../../pages/CreateNewAction/CreateNewAction';
import { AddActionToEmployee} from '../../pages/AddHistoryEmployee/AddActionToEmployee';
import { SearchEmployee } from '../../pages/SearchEmployee/SearchEmployee';
import { SearchLog } from '../../pages/SearchLog/SearchLog';
import { ShowMyHistory } from '../../pages/ShowMyHistory/ShowMyHistory';
import { PageNotFound } from '../../pages/PageNotFound/PageNotFound';

// Array of routes

export const NavWeb : INavigationPart[] = [
        {path: "/", name:"Home Page",element:<HomePage/>,isNeedAuth:false,isPrivate:false,isInMenu:true},
        {path: "/login", name:"Log in",element:<LogIn/>,isNeedAuth:false,isPrivate:false,isInMenu:true},
        {path: "/signUp", name:"Sign Up",element:<SignUp/>,isNeedAuth:false,isPrivate:false,isInMenu:true},
        {path: "/", name:"Log Out",element:<HomePage/>,isNeedAuth:false,isPrivate:true,isInMenu:true},
        {path: "/Dashboard", name:"Dashboard",element:<Dashboard/>,isNeedAuth:false,isPrivate:true,isInMenu:true},
        {path: "/SearchEmployee", name:"Search Employee",element:<SearchEmployee/>,isNeedAuth:true,isPrivate:true,isInMenu:true},
        {path: "/AddActionToEmployee/:id", name:"Add Action To Employee",element:<AddActionToEmployee/>,isNeedAuth:true,isPrivate:true,isInMenu:true},
        {path: "/CreateNewEmployee", name:"Create New Employee",element:<CreateNewEmployee/>,isNeedAuth:true,isPrivate:true,isInMenu:true},
        {path: "/CreateNewAction", name:"Create New Action",element:<CreateNewAction/>,isNeedAuth:true,isPrivate:true,isInMenu:false},
        {path: "/SearchLog", name:"Search Log",element:<SearchLog/>,isNeedAuth:true,isPrivate:true,isInMenu:true},
        {path: "/ShowMyHistory", name:"Show My History",element:<ShowMyHistory/>,isNeedAuth:false,isPrivate:true,isInMenu:true},
        {path: "*", name:"Page Not Found",element:<PageNotFound/>,isNeedAuth:false,isPrivate:false,isInMenu:false},
    ]