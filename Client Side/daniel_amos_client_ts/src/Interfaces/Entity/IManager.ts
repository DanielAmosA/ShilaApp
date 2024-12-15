import { IEmployee } from './IEmployee';
export interface IManager {
    id: number;
    role: string;
    department: string;
    employeeID: number;
    employee : IEmployee;
  }