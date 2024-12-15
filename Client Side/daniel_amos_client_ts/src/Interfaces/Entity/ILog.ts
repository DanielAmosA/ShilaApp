export interface ILog{
    id:number;
    type:string;
    info:string;
    created:Date;
    requestData?:string;
    exceptionData?:string;
}