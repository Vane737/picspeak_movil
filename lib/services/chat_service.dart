import 'dart:convert';

import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/models/user.dart';

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
