//#region Validate Funcs 

export const ValidateFullName = (fullName: string): string => {
    if (fullName.trim().length === 0) {
        return "שם מלא לא יכול להיות ריק";
    }
    return "";
};

export const ValidateEmail = (email: string): string => {
    const isEmailCheck = /^[^\s@]+@[^\s@]+\.[^\s@]+(\.[^\s@]+)?$/;
    // return isEmailCheck.test(String(email).toLowerCase());
    if (!isEmailCheck.test(email)) {
        return "פורמט אימייל לא תקין";
    }
    return "";
};

export const ValidatePhone = (phone: string): string => {
    const isPhoneCheck = /^(?:\+972|0)5\d{8}$/;
    // return isEmailCheck.test(String(email).toLowerCase());
    if (!isPhoneCheck.test(phone)) {
        return "פורמט פלאפון לא תקין";
    }
    return "";
};

export const ValidateDepartment = (department: string): string => {
    if (department.trim().length === 0) {
        return "שם מחלקה לא יכול להיות ריק";
    }
    if (!/^\S+$/.test(department)) {
        return "שם מחלקה לא יכול להכיל רווח";
    }
    return "";
};

export const ValidateType = (type: string): string => {
    if (type.trim().length === 0) {
        return "סוג פעולה לא יכול להיות ריק";
    }
    if (!/^\S+$/.test(type)) {
        return "סוג פעולה לא יכול להכיל רווח";
    }
    return "";
};

export const ValidateDescription = (description: string): string => {
    if (description.trim().length === 0) {
        return "תיאור פעולה לא יכול להיות ריק";
    }
    return "";
};

export const ValidatePassword = (password: string): string => {
    if (password.length < 8) {
        return "הסיסמה חייבת להיות לפחות 8 תווים";
    }
    if (password.length > 20) {
        return "הסיסמה יכולה להכיל עד 20 תווים";
    }
    if (!/[A-Z]/.test(password)) {
        return "הסיסמה חייבת לכלול לפחות אות אנגלית גדולה אחת";
    }
    if (!/[a-z]/.test(password)) {
        return "הסיסמה חייבת לכלול לפחות אות אנגלית קטנה אחת";
    }
    if (!/[0-9]/.test(password)) {
        return "הסיסמה חייבת לכלול לפחות מספר אחד";
    }
    if (!/[!@#$%^&*]/.test(password)) {
        return "הסיסמה חייבת לכלול לפחות תו מיוחד (!@#$%^&*)";
    }
    return "";
};

export const ValidateConfirmPassword = (
    password: string,
    confirmPassword: string
) => {
    if (confirmPassword !== password) {
        return "הסיסמאות אינן תואמות";
    }
    return "";
};

//#endregion