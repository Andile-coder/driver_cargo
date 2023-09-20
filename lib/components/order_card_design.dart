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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => OrderDetailsScreen(orderID: orderID)),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.all(8),
        height: itemCount! * 50,
        child: ListView.builder(
          itemCount: 1,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return placedOrderDesignWidget(context, model);
          },
        ),
      ),
    );
  }
}

Widget placedOrderDesignWidget(
    BuildContext context, Map<String, dynamic>? model) {
  String order_number = model!['order_number'];
  String parcel_name = model['parcel_name'];
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 3,
          offset: Offset(2, 2),
        ),
      ],
    ),
    width: MediaQuery.of(context).size.width,
    height: 80,
    child: Row(
      children: [
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(30),
        //   child: Image.network(
        //     model.thumbnailUrl!,
        //     width: 120,
        //   ),
        // ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      '$parcel_name',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    " ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              //total number
              Row(
                children: [
                  const Text(
                    "Order no: ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$order_number',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
