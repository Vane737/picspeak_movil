import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picspeak_front/Api/api.dart';
import 'package:logger/logger.dart';

class ConfigurationService {
  static final Logger logger = Logger();

  Future<dynamic> getNacionalidades() async {
    final Uri uri = Uri.parse('${ApiRoutes.baseUrl}nacionality');
    final response = await http.get(uri);

    // Aquí se usa decode() para decodificar la respuesta JSON
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      logger.e("DESDE LA API: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }

  Future<dynamic> getLanguage() async {
    final Uri uri = Uri.parse('${ApiRoutes.baseUrl}language');
    final response = await http.get(uri);

    // Aquí se usa decode() para decodificar la respuesta JSON
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      logger.e("Language: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }

  Future<dynamic> setLanguageNationalityUser(
      int? user_id, int? language_id, int? nationality_id) async {
    if (user_id == null || language_id == null || nationality_id == null) {
      throw Exception('Alguno de los valores es nulo (null).');
    }

    final Uri uri = Uri.parse(
        '${ApiRoutes.baseUrl}configuration/user/$user_id/language-nacionality');
    final response = await http.post(uri, body: {
      'nationality_id': nationality_id.toString(),
      'language_id': language_id.toString(),
    });
    final jsonResponse = jsonDecode(response.body);
    print("respuesta json: ${jsonResponse}");
    print("response: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      logger.e("response: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }

  Future<dynamic> setInappropiateContentUser(
      int? user_id, List<String> inapropiado) async {
    if (user_id == null || inapropiado == null) {
      throw Exception('Alguno de los valores es nulo (null).');
    }

    final Uri uri = Uri.parse(
        '${ApiRoutes.baseUrl}configuration/user/$user_id/inappropriate-contents-user');
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json"
      }, // Añadir el encabezado JSON
      body: jsonEncode(inapropiado),
    );
    final jsonResponse = jsonDecode(response.body);
    print("respuesta json: ${jsonResponse}");
    print("response: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      logger.e("response: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }
Future<dynamic> setInterestUser(
      int? user_id, List<String> interests) async {
    if (user_id == null || interests == null) {
      throw Exception('Alguno de los valores es nulo (null).');
    }

    final Uri uri = Uri.parse(
        '${ApiRoutes.baseUrl}configuration/user/$user_id/interests-user');
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json"
      }, // Añadir el encabezado JSON
      body: jsonEncode(interests),
    );
    final jsonResponse = jsonDecode(response.body);
    print("respuesta json: ${jsonResponse}");
    print("response: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      logger.e("response: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }
  Future<dynamic> setLanguagesUser(
      int? user_id, List<String> languages) async {
    if (user_id == null || languages == null) {
      throw Exception('Alguno de los valores es nulo (null).');
    }

    final Uri uri = Uri.parse(
        '${ApiRoutes.baseUrl}configuration/user/$user_id/language-user');
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json"
      }, // Añadir el encabezado JSON
      body: jsonEncode(languages),
    );
    final jsonResponse = jsonDecode(response.body);
    print("respuesta json: ${jsonResponse}");
    print("response: ${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      logger.e("response: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }
  Future<dynamic> getInappropriateContents() async {
    final Uri uri = Uri.parse('${ApiRoutes.baseUrl}inappropriate-content');
    final response = await http.get(uri);

    // Aquí se usa decode() para decodificar la respuesta JSON
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      logger.e("contenido inapropiado: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }

  Future<dynamic> getInterests() async {
    final Uri uri = Uri.parse('${ApiRoutes.baseUrl}interest');
    final response = await http.get(uri);

    // Aquí se usa decode() para decodificar la respuesta JSON
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      logger.e("intereses: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }
}
