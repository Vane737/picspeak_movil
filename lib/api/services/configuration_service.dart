import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:picspeak_front/Api/api.dart';
import 'package:logger/logger.dart';

class ConfigurationService {
  static final Logger logger = Logger();

  Future<dynamic> getNacionalidades() async {
    final Uri uri =
        Uri.parse('${ApiRoutes.baseUrl}configuration/language-nacionalities/');
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

  Future<dynamic> getLanguage(int id) async {
    final Uri uri = Uri.parse(
        '${ApiRoutes.baseUrl}configuration/nacionality/$id/language-nacionality/');
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
    final Uri uri =
        Uri.parse('${ApiRoutes.baseUrl}user/$user_id/language-nacionality');
    final response = await http.post(uri,
        body: {nationality_id: nationality_id, language_id: language_id});
    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      logger.e("response: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }
}
