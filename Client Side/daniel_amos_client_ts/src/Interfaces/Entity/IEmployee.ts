export interface IEmployee {
    id?: number;
    fullName: string;
    email: string;
    phone:string;
    password: string;
    created? : Date;
    guid? : string;
    managerID?:number,
    managerName?:string
    managerEmployeeID?:number;
  }