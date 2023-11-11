// ------- STRINGS ------------------
const baseUrl = "http://192.168.0.15:3000/api/v1";
const loginUrl = '$baseUrl/auth/login';
const registerUrl = '$baseUrl/auth/register';
const logoutUrl = '${baseUrl}logout';
const profileUrl = '$baseUrl/auth/profile';
const verifyEmailUrl = '$baseUrl/auth/verify_email';

const nationalities='$baseUrl/nacionality';
const languages='$baseUrl/language';
const inappropriates='$baseUrl/inappropriate-content';
const interests='$baseUrl/interest';
const configuration='$baseUrl/configuration/user'; //para settear con solicitudes post


const Map<String, String> headers = {"Accept": "application/json"};

// ------ Errors -----------------
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again';