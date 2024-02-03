// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:picspeak_front/services/auth_service.dart';
import 'package:picspeak_front/models/api_response.dart';



Future<ApiResponse> getSuggestFriend(int? id) async {
  print("ENTRANDO AL METODO GET SUGGESTFRIEND $id");
  ApiResponse apiResponse = ApiResponse();
  final Uri uri = Uri.parse('$suggestUser/$id');
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("ENTRA A 200");
      print("RESPONSE SUGGEST:${jsonDecode(response.body)}");
      var list = jsonDecode(response.body) as List;
      apiResponse.data = list;
    } else {
      apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    print('$e');
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> getContact(int? id) async {
  print("ENTRANDO AL METODO GET CONTACTS $id");
  ApiResponse apiResponse = ApiResponse();
  final Uri uri = Uri.parse('$contact/user/$id');
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      print("ENTRA A 200");
      print("RESPONSE CONTACT:${jsonDecode(response.body)}");
      var list = jsonDecode(response.body)["data"] as List;
      apiResponse.data = list;
    } else {
      apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    print(' desde la api $e');
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> addSuggest(int? userId, int? contactId) async {
  print("ENTRANDO ADD SUGGEST $userId");
  ApiResponse apiResponse = ApiResponse();
  final Uri uri = Uri.parse(contact);
  try {
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'contactId': contactId, 'user_id': userId}));
    if (response.statusCode == 201) {
      print("ENTRA A 201");
      print("RESPONSE SUGGEST:${jsonDecode(response.body)}");
      var responseData = jsonDecode(response.body);
      // Verifica si 'data' está presente en la respuesta
      if (responseData.containsKey('data')) {
        // Si está presente, asigna 'data' directamente a 'apiResponse.data'
        apiResponse.data = responseData['data'];
      } else {
        // Si 'data' no está presente, asigna toda la respuesta a 'apiResponse.data'
        apiResponse.data = responseData;
      }
    } else {
      apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    print('Desde la API $e');
    apiResponse.error = serverError;
  }
  return apiResponse;
}
//****Chat */
Future<dynamic> getAllChatByUser() async {
  final userId = getUserId();
  print('USER ID $userId');
  
  final Uri uri = Uri.parse('$chatsByUserUrl$userId');
  final response = await http.get(uri);
  final jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

