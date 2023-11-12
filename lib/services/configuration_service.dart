import 'dart:convert';

import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:picspeak_front/models/api_response.dart';

class ConfigurationService {
  static final Logger logger = Logger();

  Future<dynamic> getNacionalidades() async {
    final Uri uri = Uri.parse(nationalities);
    final response = await http.get(uri);

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      logger.e("DESDE LA API: ${jsonResponse['data']}");
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
      logger.e("Language: ${jsonResponse['data']}");
      return jsonResponse['data'];
    } else {
      throw Exception('Error en la solicitud: ${response.reasonPhrase}');
    }
  }

  Future<dynamic> getInappropriateContents() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final Uri uri = Uri.parse(inappropriates);
      final response = await http.get(uri);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data'];
          break;
        case 401:
          apiResponse.error = unauthorized;
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

  Future<dynamic> getInterests() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final Uri uri = Uri.parse(interests);
      final response = await http.get(uri);
      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['data'];
          break;
        case 401:
          apiResponse.error = unauthorized;
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

  Future<dynamic> setLanguageNationalityUser(
      int? user_id, int? language_id, int? nationality_id) async {
    if (user_id == null || language_id == null || nationality_id == null) {
      throw Exception('Alguno de los valores es nulo (null).');
    }

    final Uri uri = Uri.parse('$configuration/$user_id/language-nacionality');
    final response = await http.post(uri,headers: headers, body: {
      'nationality_id': nationality_id,
      'language_id': language_id,
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

    final Uri uri =
        Uri.parse('$configuration/$user_id/inappropriate-contents-user');
    final response = await http.post(
      uri,
      headers: headers,
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

  Future<dynamic> setInterestUser(int? user_id, List<String> interests) async {
    if (user_id == null || interests == null) {
      throw Exception('Alguno de los valores es nulo (null).');
    }

    final Uri uri = Uri.parse('$configuration/$user_id/interests-user');
    final response = await http.post(
      uri,
      headers: headers,
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

  Future<dynamic> setLanguagesUser(int? user_id, List<String> languages) async {
    if (user_id == null || languages == null) {
      throw Exception('Alguno de los valores es nulo (null).');
    }

    final Uri uri = Uri.parse('$configuration/$user_id/language-user');
    final response = await http.post(
      uri,
      headers: headers,
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
}
