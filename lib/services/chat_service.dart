// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:picspeak_front/services/auth_service.dart';
import 'package:picspeak_front/models/api_response.dart';

Future<ApiResponse> getSuggestFriend(int? id) async {
  ApiResponse apiResponse = ApiResponse();
  final Uri uri = Uri.parse('$suggestUser/$id');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
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
  ApiResponse apiResponse = ApiResponse();
  final Uri uri = Uri.parse('$contact/user/$id');

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      var list = jsonDecode(response.body)["data"] as List;
      apiResponse.data = list;
    } else {
      apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<ApiResponse> addSuggest(int? userId, int? contactId) async {
  ApiResponse apiResponse = ApiResponse();
  final Uri uri = Uri.parse(contact);

  try {
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'contactId': contactId, 'user_id': userId}));

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);

      if (responseData.containsKey('data')) {
        apiResponse.data = responseData['data'];
      } else {
        apiResponse.data = responseData;
      }
    } else {
      apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    print(e);
    apiResponse.error = serverError;
  }
  return apiResponse;
}

Future<dynamic> getAllChatByUser() async {
  final userId = getUserId();
  final Uri uri = Uri.parse('$chatsByUserUrl$userId');
  final response = await http.get(uri);
  final jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> getFastAnswers(String message) async {
  final response = await http.post(Uri.parse(fastAnswers),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'message': message}));
  final jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 201) {
    List<String> answers = List<String>.from(jsonResponse['answers']);
    return answers;
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}
