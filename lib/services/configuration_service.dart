// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getNacionalidades() async {
  final Uri uri = Uri.parse(nationalities);
  final response = await http.get(uri);
  final jsonResponse = jsonDecode(response.body);
  print('NACIONALIDADES $jsonResponse');
  if (response.statusCode == 200) {
    print("entra a status 200 de nacionality");
        print("response nacionalidades: $jsonResponse");
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> getLanguage() async {
  final Uri uri = Uri.parse(languages);
  final response = await http.get(uri);

  // Aquí se usa decode() para decodificar la respuesta JSON
  final jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> getInappropriateContents() async {
  final Uri uri = Uri.parse(inappropriates);
  final response = await http.get(uri);
  final jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> getInterests() async {
  final Uri uri = Uri.parse(interests);
  final response = await http.get(uri);
  final jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> getInterestsUser( int? userId) async {
  final Uri uri = Uri.parse('$configurationUser/interest-user/$userId');
  final response = await http.get(uri);
  final jsonResponse = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> setLanguageNationalityUser(
    int? userId, int? languageId, int? nationalityId) async {
  if (userId == null || languageId == null || nationalityId == null) {
    throw Exception('Alguno de los valores es nulo (null).');
  }

  final Uri uri = Uri.parse('$configuration/$userId/language-nacionality');
  final response = await http.post(uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'nationality_id': nationalityId,
        'language_id': languageId,
      }));
  final jsonResponse = jsonDecode(response.body);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> setInappropiateContentUser(
    int? userId, List<String> inapropiado) async {
  if (userId == null) {
    throw Exception('Alguno de los valores es nulo (null).');
  }

  final Uri uri =
      Uri.parse('$configuration/$userId/inappropriate-contents-user');
  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(inapropiado),
  );
  final jsonResponse = jsonDecode(response.body);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> setInterestUser(int? userId, List<String> interests) async {
  if (userId == null) {
    throw Exception('Alguno de los valores es nulo (null).');
  }

  final Uri uri = Uri.parse('$configuration/$userId/interests-user');
  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"}, // Añadir el encabezado JSON
    body: jsonEncode(interests),
  );
  final jsonResponse = jsonDecode(response.body);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}

Future<dynamic> setLanguagesUser(int? userId, List<String> languages) async {
  if (userId == null) {
    throw Exception('Alguno de los valores es nulo (null).');
  }

  final Uri uri = Uri.parse(
      '$configuration/$userId/language-user');
  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"}, // Añadir el encabezado JSON
    body: jsonEncode(languages),
  );
  final jsonResponse = jsonDecode(response.body);
  if (response.statusCode >= 200 && response.statusCode < 300) {
    return jsonResponse['data'];
  } else {
    throw Exception('Error en la solicitud: ${response.reasonPhrase}');
  }
}
