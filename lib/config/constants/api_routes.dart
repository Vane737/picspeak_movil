import 'package:intl/intl.dart';

// ------- STRINGS ------------------
const baseUrl = "http://3.16.67.99:3000/api/v1";
//const baseUrl = "http://10.0.2.2:3000/api/v1";
//const baseUrl = "http://192.168.0.12:3000/api/v1";
const socketUrl = "http://3.16.67.99:3000";
//const socketUrl = "http://10.0.2.2:3000";
//const socketUrl = "http://192.168.0.12:3000";
const loginUrl = '$baseUrl/auth/login';
const registerUrl = '$baseUrl/auth/register';
const logoutUrl = '${baseUrl}logout';
const profileUrl = '$baseUrl/auth/profile';
const updateProfileUrl = '$baseUrl/auth/update-profile';
const verifyEmailUrl = '$baseUrl/auth/verify_email';

const userUrl='$baseUrl/users';
const nationalities='$baseUrl/nacionality';
const languages='$baseUrl/language';
const inappropriates='$baseUrl/inappropriate-content';
const interests='$baseUrl/interest';
const configuration='$baseUrl/configuration/user'; //para settear con solicitudes post
const configurationUser='$baseUrl/configuration'; //para settear con solicitudes post
const chatsByUserUrl = '$baseUrl/chat';
const suggestUser='$baseUrl/users/suggest';//para la sugerencia de usuarios
const contact='$baseUrl/contact';//para los contactos
const userLanguageUrl='$baseUrl/configuration/language-user';

const Map<String, String> headers = {"Accept": "application/json"};

// ------ Errors -----------------
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again';

String token = "";
int userId = 0;
int chatId = 0;

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  
  String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  
  return formattedDateTime;
}