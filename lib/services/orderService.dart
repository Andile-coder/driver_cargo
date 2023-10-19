import 'package:driver_cargo/config/index.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  String? parcel_name;
  String? required_temp;
  String? pickup_address;
  String? droppoff_address;
  OrderService();

  Config config = new Config();

  Future<void> createOrder(
      {required parcel_name,
      required required_temp,
      required pickup_address,
      required droppoff_address}) async {
    try {
      String? token = await config.getToken();
      Response response = await post(Uri.parse(config.getHost() + "/order"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer " + token!
          },
          body: jsonEncode(<String, String>{
            "parcel_name": parcel_name,
            "pickup_address": pickup_address,
            "droppoff_address": droppoff_address,
            "required_temp": required_temp
          }));

      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  ordersToJson() {}

  Future<Map<dynamic, dynamic>?> getDriversOrders() async {
    try {
      String? token = await config.getToken();
      Response response = await get(
        Uri.parse(config.getHost() + "/orders/driver"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + token!
        },
      );
      if (response.statusCode == 201) {
        Map<dynamic, dynamic> orders = jsonDecode(response.body);
        return orders;
      } else {}
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> getOrderHistory() async {
    try {
      String? token = await config.getToken();
      Response response = await get(
        Uri.parse(config.getHost() + "/order"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + token!
        },
      );
      if (response.statusCode == 201) {
        Map<dynamic, dynamic> orders = jsonDecode(response.body);
        return orders;
      } else {}
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Map<dynamic, dynamic>?> getOrder(String order_number) async {
    try {
      String? token = await config.getToken();
      Response response = await get(
        Uri.parse(config.getHost() + "/orders/user/" + order_number),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + token!
        },
      );
      if (response.statusCode == 201) {
        Map<dynamic, dynamic> order = jsonDecode(response.body);
        return order;
      } else {}
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<int> setOrderToInProgress(String order_number) async {
    try {
      String? token = await config.getToken();
      Response response = await patch(
        Uri.parse(config.getHost() + "/orders/inprogress/" + order_number),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer " + token!
        },
      );
      print("response ${response.statusCode}");
      if (response.statusCode == 201) {
        Map<dynamic, dynamic> order = jsonDecode(response.body);
        return response.statusCode;
      } else {
        response.statusCode;
      }
    } catch (e) {
      print(e);
    }
    return 0;
  }
}
