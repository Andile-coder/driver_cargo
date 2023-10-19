import 'package:driver_cargo/assistantMethods/get_current_location.dart';
import 'package:driver_cargo/components/loading_dialog.dart';
import 'package:driver_cargo/screens/pick_up_screen.dart';
import 'package:driver_cargo/services/orderService.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../models/address.dart';
import '../splash_screen/splash_screen.dart';

class ShipmentAddressDesign extends StatefulWidget {
  final String? orderStatus;
  final String? orderId;
  final Map<dynamic, dynamic> order;

  const ShipmentAddressDesign(
      {Key? key, this.orderStatus, this.orderId, required this.order})
      : super(key: key);

  @override
  State<ShipmentAddressDesign> createState() => _ShipmentAddressDesignState();
}

class _ShipmentAddressDesignState extends State<ShipmentAddressDesign> {
  confirmedParcelShipment(
    BuildContext context,
    String getOrderID,
    String sellerId,
    String purchaserId,
  ) {}
  Map<dynamic, dynamic> orderTemp = {};

  getOrder() async {
    OrderService order = OrderService();
    orderTemp = (await order.getOrder(widget.orderId as String))!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getOrder();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Shipping Details: ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6),
        buildCard("Collection", "Pickup package at this address", 'sender',
            widget.order),
        const SizedBox(height: 6),
        buildCard("Deliver", "Deliver package at this address", "receiver",
            widget.order),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              widget.order["status"] == "ACCEPTED"
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) =>
                                  PickupScreen(order: widget.order)),
                            ),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(3.0, -1.0),
                              colors: [
                                Color(0xFF004B8D),
                                Color(0xFFffffff),
                              ],
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Start Pickup",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )),
                        ),
                      ),
                    )
                  : Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(3.0, -1.0),
                              colors: [
                                Color(0xFF004B8D),
                                Color(0xFFffffff),
                              ],
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Go back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          )),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

Widget buildCard(String title, String subtitle, String person,
        Map<dynamic, dynamic> order) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpandablePanel(
            header: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            collapsed: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(subtitle)),
            expanded: Address(person, order),
          ),
        ),
      ),
    );

Widget Address(String name, Map<dynamic, dynamic> order) => Padding(
    padding: const EdgeInsets.all(10),
    child: order.isNotEmpty
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Name"),
                  Text(
                    order['$name' '_full_name'],
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Cell number"),
                  Text(
                    order['$name' '_number'],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Email"),
                  Text(
                    order['$name' '_email'],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Building Type"),
                  Text(
                    "Apartment",
                  )
                ],
              )
            ],
          )
        : const LoadingDialog(
            message: "loading",
          ));
