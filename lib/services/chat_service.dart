// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:picspeak_front/services/auth_service.dart';

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

