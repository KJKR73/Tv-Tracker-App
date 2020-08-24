// All the authentication functions will be present here
import 'dart:convert';
import 'package:http/http.dart';

class AuthService {
  // Makes the user login the first time
  Future<dynamic> postLogin(data) async {
    var response = await post(
      'http://192.168.29.72:7000/api/login/',
      body: json.encode(data),
      headers: {"Content-Type": "application/json"},
    );
    return response.body;
  }
}
