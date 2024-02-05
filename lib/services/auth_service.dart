// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/models/user.dart';
//import 'package:picspeak_front/views/interfaces/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginUrl),
        headers: headers, body: {'email': email, 'password': password});
    print('LOGIN ${response.body}');
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        /* final loginData = Login.fromJson(jsonDecode(response.body));
        token = loginData.user.token;
        print("Token del login con variable lgobal $token");
        await saveTokenToLocalStorage(loginData.user.token); */
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('ERROR $e');
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> register(String name, String lastname, String username,
    String birthDate, String email, String password, String? photourl) async {
  ApiResponse apiResponse = ApiResponse();
  
  try {
    final response =
        await http.post(Uri.parse(registerUrl), headers: headers, body: {
      'name': name,
      'lastname': lastname,
      'username': username,
      'birthDate': birthDate,
      'email': email,
      'password': password,
      'photo_url': photourl
    });

    print('REQUEST $name $lastname $email $username $password $photourl $birthDate');

    switch (response.statusCode) {
      case 201:
        print("register: ${jsonDecode(response.body)}");
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        /* saveUserInfo(apiResponse.data as User);
        User user = User.fromJson(jsonDecode(response.body));
        userId = user.id ?? 0;
        print("User ID: $userId"); */
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> updateUser(String name, String lastname, String username,
    String birthDate, String? photourl, String? email) async {
  print(name);
  print(lastname);
  print(username);
  print(birthDate);
  print(photourl);
  print(email);

  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken(); 
    print('Este es el token $token');
    final response = await http.put(
      Uri.parse(
          updateProfileUrl), // Utiliza la URL adecuada para actualizar un usuario específico
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        if (name.isNotEmpty) 'name': name,
        if (lastname.isNotEmpty) 'lastname': lastname,
        if (username.isNotEmpty) 'username': username,
        if (birthDate.isNotEmpty) 'birthDate': birthDate,
        if (photourl != null) 'photo_url': photourl,
        'email': email,
      },
    );

    print(response.body);
    print(response.statusCode);
    switch (response.statusCode) {
      case 200: // Cambiado a 200 para representar una actualización exitosa
        print(response.body);
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        print(response.body);
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        print(response.body);
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    print(e);
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getUser(int? id) async {
  ApiResponse apiResponse = ApiResponse();
  // print("Este es el token desde getuserDetail: ${tokenizer}");
  //print("Este es el token global token");
  try {
    String token = await getToken();
    if (token.isNotEmpty) {
      final response = await http.get(Uri.parse('$userUrl/find/$id'), headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer $token'
      });
      print('USER DETAIL ${response.body}');
      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(jsonDecode(response.body));
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } else {
      //print("No se pudo obtener el token de SharedPreferences.");
      apiResponse.error = "No se pudo obtener el token de SharedPreferences.";
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  // print("Este es el token desde getuserDetail: ${tokenizer}");
  print("Este es el token global token");
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print(token);
    if (token.isNotEmpty) {
      print("TOKEEEE getUserDetail(): $token");
      final response = await http.get(Uri.parse(profileUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      print('USER DETAIL ${response.body}');
      switch (response.statusCode) {
        case 200:
          apiResponse.data = User.fromJson(jsonDecode(response.body));
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } else {
      print("No se pudo obtener el token de SharedPreferences.");
      apiResponse.error = "No se pudo obtener el token de SharedPreferences.";
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  print("entra al GET TOKEN ***********************");
  return pref.getString('token') ?? '';
}

Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}

Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}

Future<ApiResponse> verifyEmail(String token) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(verifyEmailUrl),
        headers: headers, body: {'token': token});

    print('Response${response.body}');
    print(response.statusCode);

    switch (response.statusCode) {
      case 201:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

/* // Save user information in SharedPreferences
Future<void> saveUserInfo(User user) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('token', user.token ?? '');
  pref.setInt('userId', user.id ?? 0);
}


Future<void> saveTokenToLocalStorage(String token) async {
  print("Desde el saveTonek: $token");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}


// Para obtener el token almacenado
Future<String?> getTokenFromLocalStorage() async { 
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}*/