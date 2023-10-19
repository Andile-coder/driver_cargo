// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:driver_cargo/components/progress_bar.dart';
import 'package:driver_cargo/components/shipment_address_design.dart';
import 'package:driver_cargo/components/status_banner.dart';
import 'package:driver_cargo/services/orderService.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import '../models/address.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String? orderID;

  const OrderDetailsScreen({super.key, this.orderID});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";
  String orderByUser = "";
  String sellerId = "";
  Map<dynamic, dynamic> orderDetailed = {};

  getOrderInfo() async {
    OrderService order = OrderService();
    String orderId = widget.orderID ?? "";
    Map<dynamic, dynamic>? temp = await order.getOrder(orderId);
    orderDetailed = temp!["data"];
    orderStatus = orderDetailed['status'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOrderInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            StatusBanner(
              status: true,
              orderStatus: orderStatus,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Center(
                  child: Text(
                    orderStatus,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Order ID: ${widget.orderID}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "2023",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            const Divider(thickness: 4),
            orderDetailed["status"] == "DELIVERED"
                ? Image.asset(
                    "assets/images/success.jpg",
                    height: 300,
                    width: 300,
                  )
                : Image.asset(
                    "assets/images/confirm_pick.png",
                    height: 300,
                    width: 300,
                  ),
            const Divider(thickness: 4),
            orderDetailed.isNotEmpty
                ? ShipmentAddressDesign(
                    orderStatus: orderDetailed["status"],
                    orderId: widget.orderID,
                    order: orderDetailed)
                : circularProgress()
          ],
        )),
      ),
    );
  }
}
