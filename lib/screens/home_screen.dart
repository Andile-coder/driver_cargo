// ignore_for_file: unused_field

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_cargo/assistantMethods/get_current_location.dart';
import 'package:driver_cargo/auth_screens/login.dart';
import 'package:driver_cargo/config/index.dart';
import 'package:driver_cargo/screens/earnings_screen.dart';
import 'package:driver_cargo/screens/new_orders_screen.dart';
import 'package:driver_cargo/services/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  Card makeDashboardItem(String title, IconData iconData, int index) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(1.0, -1.0),
                  end: FractionalOffset(-1.0, -1.0),
                  colors: [
                    Colors.amber,
                    Colors.orangeAccent,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                    offset: Offset(4, 3),
                  )
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(-1.0, 0.0),
                  end: FractionalOffset(5.0, -1.0),
                  colors: [
                    Colors.orangeAccent,
                    Colors.amber,
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                    offset: Offset(4, 3),
                  )
                ],
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //new orders
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const NewOrdersScreen())));
            }
            if (index == 1) {
              //Parcels in progress
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Text("ParcelInProgressScreen()")));
            }
            if (index == 2) {
              //not yet delivered
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Text("NotYetDeliveredScreen()")));
            }
            if (index == 3) {
              //history
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Text("HistoryScreen()")));
            }
            if (index == 4) {
              //total earnings
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EarningsScreen()));
            }
            if (index == 5) {
              //logout
              // firebaseAuth.signOut().then((value) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: ((context) => const LoginScreen())));
              // });
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String>? user;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    UserLocation uLocation = UserLocation();
    Config config = Config();
    void getUser() async {
      user = await config.getUser();
      print(user?[0]);
      setState(() {});
    }

    getUser();

    getUserLocation() async {
      Position? newPosition = await uLocation.getCurrenLocation();
      print(newPosition);
    }

    getUserLocation();

    getPerParcelDeliveryAmount();
    getRiderPreviousEarnings();
  }

  getRiderPreviousEarnings() {
    // FirebaseFirestore.instance
    //     .collection("riders")
    //     .doc(sharedPreferences!.getString("uid"))
    //     .get()
    //     .then((snap) {
    //   previousRiderEarnings = snap.data()!["earnings"].toString();
    // });
    previousRiderEarnings = "20";
  }

  // method to calculate amount per delivery
  getPerParcelDeliveryAmount() {
    // FirebaseFirestore.instance
    //     .collection("perDelivery")
    //     .doc("taydinadnan")
    //     .get()
    //     .then((snap) {
    //   perParcelDeliveryAmount = snap.data()!["amount"].toString();
    // });
    perParcelDeliveryAmount = "20";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Montserrat'),
      title: "Last Mile Delivery",
      home: Scaffold(
          body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    tileColor: const Color(0xff5ac18e),
                    title: Text("Hi ${user?[0]} !",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.white)),
                    subtitle: Text("Last Mile Delivery",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white)),
                    trailing: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/avatar.jpeg"),
                    )),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          Container(
              color: Theme.of(context).primaryColor,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(100))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    itemDashboard('New Orders', Icons.assignment, Colors.red,
                        NewOrdersScreen()),
                    itemDashboard('Inprogress ', Icons.airport_shuttle,
                        Colors.purple, NewOrdersScreen()),
                    itemDashboard('History', Icons.done_all, Colors.green,
                        NewOrdersScreen()),
                    itemDashboard('Invoice', CupertinoIcons.money_dollar_circle,
                        Colors.indigo, NewOrdersScreen()),
                    itemDashboard('Upload', CupertinoIcons.add_circled,
                        Colors.teal, NewOrdersScreen()),
                    itemDashboard('Feedback', CupertinoIcons.chat_bubble_2,
                        Colors.brown, NewOrdersScreen()),
                    itemDashboard('About', CupertinoIcons.question_circle,
                        Colors.blue, NewOrdersScreen()),
                    itemDashboard('Contact', CupertinoIcons.phone,
                        Colors.pinkAccent, NewOrdersScreen()),
                  ],
                ),
              ))
        ],
      )),
    );
  }

  itemDashboard(
          String title, IconData iconData, Color background, Widget toPage) =>
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => toPage,
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    color: Theme.of(context).primaryColor.withOpacity(.2),
                    spreadRadius: 2,
                    blurRadius: 5)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: background,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: Colors.white)),
              const SizedBox(height: 8),
              Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ),
      );
}
