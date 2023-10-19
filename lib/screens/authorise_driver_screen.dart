// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:driver_cargo/components/progress_bar.dart';
import 'package:driver_cargo/components/shipment_address_design.dart';
import 'package:driver_cargo/components/status_banner.dart';
import 'package:driver_cargo/config/index.dart';
import 'package:driver_cargo/screens/dropp_off_screen.dart';
import 'package:driver_cargo/services/orderService.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:intl/intl.dart';

import '../models/address.dart';

class AuthoriseDriverScreen extends StatefulWidget {
  final String value;
  final Map<dynamic, dynamic> order;

  const AuthoriseDriverScreen(
      {super.key, required this.value, required this.order});

  @override
  State<AuthoriseDriverScreen> createState() => _AuthoriseDriverScreenState();
}

class _AuthoriseDriverScreenState extends State<AuthoriseDriverScreen> {
  List<String>? driver;
  String driver_id = "";
  bool is_authorised = false;
  Config user = new Config();
  Map<dynamic, dynamic>? qr_code_data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser() async {
      driver = await user.getUser();
      driver_id = driver![1];
      qr_code_data = json.decode(widget.value);
      print("QR code data ${qr_code_data!['driver_id']}");
      if (qr_code_data!['driver_id'] != driver_id) {
        is_authorised = false;
      } else {
        is_authorised = true;
        setState(() {});
      }
    }

    getUser();
  }

  void startOrder() async {
    OrderService order = OrderService();
    int statusCode =
        await order.setOrderToInProgress(qr_code_data!['order_number']);

    if (statusCode == 201) {
      print("success");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DropoffScreen(order: widget.order),
            // FoundCodeScreen(screenClosed: _screenWasClosed, value: code),
          ));
    } else {
      print(statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(140, 300, 0, 0),
          child: is_authorised
              ? Column(
                  children: [
                    const Text("Authorised"),
                    TextButton(
                        onPressed: startOrder, child: const Text("Start"))
                  ],
                )
              : Column(
                  children: [
                    const Text("Unauthorised"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: const Text("Back"))
                  ],
                ),
        ),
      ),
    );
  }
}
