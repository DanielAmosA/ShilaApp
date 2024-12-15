import { IApiResponse } from "../Interfaces/Api/IApiResponse";
import { typeApiMethod, typeServiceName } from "../utils/generalVar";

//#region Members

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;

//#endregion

//#region API Methods

// Call API using the GET method, with token and parameters
export const CallApiGetAction = async (
  { serviceName, apiMethod, params, token }:
    {
      serviceName: typeServiceName,
      apiMethod?: typeApiMethod,
      params?: URLSearchParams,
      token?: string
    }
): Promise<IApiResponse> => {

  // Check if token exists, then include it in the headers
  const myHeaders = new Headers();
  myHeaders.append("Content-Type", "application/json");

  if (token) {
    myHeaders.append("Authorization", `Bearer ${token}`);
  }

  // Set the Request options
  const requestOptions = {
    method: "GET",
    headers: myHeaders,
    redirect: "follow" as RequestRedirect,
  };


  // Create the API URL
  let apiUrl = `${API_BASE_URL}/${serviceName}`;
  if (apiMethod) {
    apiUrl += `/${apiMethod}`;
  }
  if (params) {
    apiUrl += `?${params}`;
  }

  // Start the API Method and return the response as JSON
  try {
    const response = await fetch(apiUrl, requestOptions);

    if (!response.ok) {
      // Try to get the error message from the response
      const errorData = await response.json();
      if (errorData.message || errorData.error) {
        throw new Error(errorData.message || errorData.error);
      } else {
        // If no specific error message, throw the status text
        alert(`Error: ${response.statusText}`);
        throw new Error(response.statusText);
      }
    }

    return { success: true, data: await response.json() };
  }
  catch (error) {
    // Handle any other errors (network errors, parsing errors, etc.)
    console.error('API Error:', error);
    if (typeof error === "string") {
      return { success: false, error: error };
    } else if (error instanceof Error) {
      return { success: false, error: error.message };
    } else {
      return { success: false, error: "An unknown error occurred" };
    }

  }
};

// Call API using the POST method, with token, parameters, and body
export const CallApiPostAction = async (
  { serviceName, apiMethod, params, body, token }: {
    serviceName: typeServiceName,
    apiMethod?: typeApiMethod,
    params?: URLSearchParams;
    body?: unknown;
    token?: string;
  }
): Promise<IApiResponse> => {
  // Check if token exists, then include it in the headers
  const myHeaders = new Headers();
  myHeaders.append("Content-Type", "application/json");
  if (token) {
    myHeaders.append("Authorization", `Bearer ${token}`);
  }

  // Set the Request options with body as json
  const requestOptions = {
    method: "POST",
    headers: myHeaders,
    body: body ? JSON.stringify(body) : null,
    redirect: "follow" as RequestRedirect,
  };

  // Create the API URL
  let apiUrl = `${API_BASE_URL}/${serviceName}`;
  if (apiMethod) {
    apiUrl += `/${apiMethod}`;
  }
  if (params) {
    apiUrl += `?${params}`;
  }

  // Start the API Method and return the response as JSON
  try {
    const response = await fetch(apiUrl, requestOptions);
    if (!response.ok) {
      // Try to get the error message from the response
      const errorData = await response.json();
      if (errorData.message || errorData.error) {
        throw new Error(errorData.message || errorData.error);
      } else {
        // If no specific error message, throw the status text
        alert(`Error: ${response.statusText}`);
        throw new Error(response.statusText);
      }
    }

    return { success: true, data: await response.json() };
  }
  catch (error) {
    // Handle any other errors (network errors, parsing errors, etc.)
    console.error('API Error:', error);
    if (typeof error === "string") {
      return { success: false, error: error };
    } else if (error instanceof Error) {
      return { success: false, error: error.message };
    } else {
      return { success: false, error: "An unknown error occurred" };
    }

  }
};

//#endregion
