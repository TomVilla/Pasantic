import 'dart:convert';

import 'package:http/http.dart';

class LoginService {
  final String apiUrl = "http://127.0.0.1:3000/signin";

  Future<Response> login(String email, String password) async {
    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: {'correo': email, 'contra': password}
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to login');
    }
  }
}