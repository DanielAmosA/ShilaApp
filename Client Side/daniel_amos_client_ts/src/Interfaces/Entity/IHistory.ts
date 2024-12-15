
export interface IHistory {
    id?:number;
    employeeID: number;
    date: Date;
    type?: string;
    description?:string;
    actionID:number;
    managerID?:number;
    managerFullName?: string;
    managerEmployeeID?:number;
  }