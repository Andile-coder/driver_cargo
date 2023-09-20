import 'package:driver_cargo/config/index.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Auth {
  String? username;
  String? password;
  String? user_id;
  String? email;
  String? token;
  String? cell_phone_number;

  String host = "172.17.235.114"; //dev only
  String port = "3000"; //dev only

  Auth();
  Config config = new Config();

  Future<int> loginUser({required email, required password}) async {
    try {
      Response response = await post(
          Uri.parse(config.getHost() + "/driver/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"email": email, "password": password}));

      if (response.statusCode == 200) {
        Map<dynamic, dynamic> user = jsonDecode(response.body);

        config.storeToken(user['accessToken']);
        config.storeUser(
            [user["message"]["username"], user["message"]["driver_id"]]);
      }
      return response.statusCode;
    } catch (e) {
      print(e);
    }
    return 0;
  }

  Future<int> RegisterUser(
      {required email,
      required password,
      required username,
      required cellPhoneNumber}) async {
    try {
      Response response =
          await post(Uri.parse(config.getHost() + "/driver/register"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                "email": email,
                "password": password,
                "username": username,
                'cell_phone_number': cellPhoneNumber
              }));
      return response.statusCode;
    } catch (e) {
      print(e);
    }
    return 0;
  }

  String? getEmail() {
    return this.email;
  }
}
