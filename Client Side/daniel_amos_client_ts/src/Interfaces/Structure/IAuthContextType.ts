import { IUserMainDetails } from "../Basic/IUserMainDetails";

export interface IAuthContextType {
    user: IUserMainDetails | null;
    login: (email: string, password: string) => Promise<string  | null>;
    logout: () => void;
  }
  