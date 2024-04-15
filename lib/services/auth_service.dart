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

    switch (response.statusCode) {
      case 200:
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
    print('$e');
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

Future<ApiResponse> updateUser(String name, String lastname, String username,
    String birthDate, String? photourl, String? email) async {

  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken(); 
    final response = await http.put(
      Uri.parse(
          updateProfileUrl),
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

    switch (response.statusCode) {
      case 200: 
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
    print(e);
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getUser(int? id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    if (token.isNotEmpty) {
      final response = await http.get(Uri.parse('$userUrl/find/$id'), headers: {
        'Accept': 'application/json',
      });

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

Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    if (token.isNotEmpty) {
      final response = await http.get(Uri.parse(profileUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

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