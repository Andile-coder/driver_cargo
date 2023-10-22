import 'package:driver_cargo/services/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  String _host = "https://cargo-ldid.onrender.com";
  // String _host = "http://172.17.208.40:3000";
  String _port = "3000";

  String getHost() {
    return this._host;
  }

  String getPort() {
    return this._port;
  }

  // Storing the JWT token
  void storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt_token', token);
  }

  void storeUser(List<String> user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('user', user);
  }

// Retrieving the JWT token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  //get user infor
  Future<List<String>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('user');
  }
}
