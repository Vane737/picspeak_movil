// ------- STRINGS ------------------
const baseUrl = "https://app-picspeak-66m7tu3mma-uc.a.run.app/api/v1";
//const baseUrl = "http://10.0.2.2:3000/api/v1";
const loginUrl = '$baseUrl/auth/login';
const registerUrl = '$baseUrl/auth/register';
const logoutUrl = '${baseUrl}logout';
const profileUrl = '$baseUrl/auth/profile';
const updateProfileUrl = '$baseUrl/auth/update-profile';
const verifyEmailUrl = '$baseUrl/auth/verify_email';

const nationalities='$baseUrl/nacionality';
const languages='$baseUrl/language';
const inappropriates='$baseUrl/inappropriate-content';
const interests='$baseUrl/interest';
const configuration='$baseUrl/configuration/user'; //para settear con solicitudes post
const configurationUser='$baseUrl/configuration'; //para settear con solicitudes post
const chatsByUserUrl = '$baseUrl/chat/';

const Map<String, String> headers = {"Accept": "application/json"};

// ------ Errors -----------------
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again';

String token = "";
int userId = 0;
int chatId = 0;