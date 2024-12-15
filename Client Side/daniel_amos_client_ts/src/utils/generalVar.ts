// Saving the types of log

import { IEmployee } from "../Interfaces/Entity/IEmployee";

export type typeLog = 'Error' | 'Info';

// Saving the names of the controllers and their corresponding services.

export type typeServiceName = 'Auth' | 'Employee' | 'Manager';
export type typeApiMethod = 'GenerateToken' |
                             'GetThePasswordByEmail' | 'SelectByEmailAndPassword' | 'SelectByContaintsFullName' | 'EmployeeInsert'|
                             'EmployeeDelete' | 'EmployeeUpdate' | 'ManagerFullDataSelectByID' |
                             'ManagerSelect' | 'SelectByManager' | 'ManagerInsert' | 'LogSelectByType' |
                             'HistoryInsert' | 'HistorySelectByEmployeeID' | 'ActionInsert' | 'ActionSelect';

  
 // Saving the data for loads and dialogs                          
export type typeKindsLoadData = 'Wait' | 'Error';
export type dialogActions = (choice?: string) => void;
export type kindButtons = 'YesNo' | 'Ok';

// Managing data retrieval and service calls optimally.
export interface SearchCache {
    timestamp: number;
    data: IEmployee[];
  }

  export const DEBOUNCE_DELAY = 300; // Waiting time between searches.
  export const MIN_SEARCH_LENGTH = 2; // Minimum characters for search.
  export const CACHE_EXPIRY = 5 * 60 * 1000; // Cache expiration - 5 minutes.
  export const MAX_CACHE_SIZE = 50; // Maximum values in the cache.

