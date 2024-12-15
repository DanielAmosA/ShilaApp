export interface IManagerData {
    id?: number;
    role: string;
    department: string;
    start : Date;
    isManager?:boolean;
    employeeID?: number;
    created : Date;
    fullName: string;
    phone:string;
    managerFullName?:string;
    email: string;
    password: string;
  }