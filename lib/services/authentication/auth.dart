// All the authentication functions will be present here
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<dynamic> registerUser(body) async {
    var response = await post(
      "http://192.168.29.72:7000/api/register/",
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<dynamic> addGlobalSeries(body) async {
    var response = await post(
      "http://192.168.29.72:7000/series/watching/add",
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<dynamic> getUserTracker() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("_id");
    var response = await post(
      "http://192.168.29.72:7000/tracker/watching/getracker",
      body: json.encode({
        "id": id,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body)["watching"];
  }

  Future<dynamic> addSeriesTracker(body) async {
    var response = await post(
      "http://192.168.29.72:7000/tracker/watching/addNewSeries",
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );

    return response.body;
  }

  Future<dynamic> updateTracker(body) async {
    var response = await post(
      "http://192.168.29.72:7000/tracker/watching/update",
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }

  Future<dynamic> addToCompleted(body) async {
    var response = await post(
      "http://192.168.29.72:7000/tracker/completed/add_to_completed",
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );

    return response;
  }

  Future<dynamic> getCompletedList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("_id");
    var response = await post(
      "http://192.168.29.72:7000/tracker/completed/get_completed",
      body: json.encode({
        "id": id,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body);
  }
}
