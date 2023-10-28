import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  postData(data, apiUrl) async {
    var fullUrl = baseUrl + apiUrl + await _getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = baseUrl + apiUrl + await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }

  getPublicData(apiUrl) async {
    String token = await getToken();
    debugPrint('Token: $token');
    http.Response response = await http.get(Uri.parse(baseUrl + apiUrl),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        });

    try {
      if (response.statusCode == 200) {
        return response;
      } else {
        return 'failed';
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return 'failed';
    }
  }
}