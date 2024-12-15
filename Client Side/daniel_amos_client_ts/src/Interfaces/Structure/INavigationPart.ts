export interface INavigationPart {
    path: string;
    name: string;
    element: JSX.Element;
    isInMenu: boolean;
    isNeedAuth:boolean;
    isPrivate: boolean;
  }
  