// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_cargo/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import '../models/items.dart';
// import '../screens/order_details_screen.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<Map<String, dynamic>> data = [
    {
      "menuID": 456,
      "sellerUID": 789,
      "itemID": 123,
      "title": "Dummy Item",
      "shortInfo": "Short info",
      "publishedDate": "Timestamp(seconds=1631404951, nanoseconds=16951000)",
      " thumbnailUrl": "https://example.com/thumbnail.jpg",
      "longDescription": "This is a long description",
      "status": "Active",
      "price": 20
    }
  ];
  final String? orderID;
  final List<String>? seperateQuantitiesList;
  final Map<String, dynamic>? model;

  OrderCard({
    Key? key,
    this.itemCount,
    this.orderID,
    this.seperateQuantitiesList,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => OrderDetailsScreen(orderID: orderID)),
            ),
          );
        },
        title: Text(model!['parcel_name']),
        subtitle: Text(model!['order_number']),
        trailing: Text(model!['status']),
      ),
    );
  }
}
