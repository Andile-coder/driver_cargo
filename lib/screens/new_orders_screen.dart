import 'package:driver_cargo/components/order_card_design.dart';
import 'package:driver_cargo/components/progress_bar.dart';
import 'package:driver_cargo/components/simple_app_bar.dart';
import 'package:driver_cargo/models/order.dart';
import 'package:driver_cargo/services/orderService.dart';
import 'package:flutter/material.dart';

import '../assistantMethods/assistant_methods.dart';

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({Key? key}) : super(key: key);

  @override
  _NewOrdersScreenState createState() => _NewOrdersScreenState();
}

class _NewOrdersScreenState extends State<NewOrdersScreen> {
  List<dynamic> driverOrders = [];
  @override
  void initState() {
    super.initState();
    OrderService order = OrderService();
    void getDriverOrders() async {
      Map<dynamic, dynamic>? temp = await order.getDriversOrders();
      driverOrders = temp!["data"];
      print(driverOrders.length);
      setState(() {});
    }

    getDriverOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: "New Orders",
      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(-1.0, 0.0),
              end: FractionalOffset(4.0, -1.0),
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFAC898),
              ],
            ),
          ),
          child: driverOrders.isNotEmpty
              ? ListView.builder(
                  itemCount: driverOrders.length,
                  itemBuilder: (context, index) {
                    String? orderID = driverOrders[index]!["order_number"];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 4),
                      child: OrderCard(
                        itemCount: driverOrders.length,
                        orderID: orderID,
                        seperateQuantitiesList: ["20"],
                        model: driverOrders[index],
                      ),
                    );
                  })
              : Center(
                  child: circularProgress(),
                )),
    );
  }
}
