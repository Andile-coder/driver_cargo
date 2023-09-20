import 'package:driver_cargo/screens/order_details_screen.dart';
import 'package:driver_cargo/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var sharedPreferences = await SharedPreferences.getInstance();
  // await Firebase.initializeApp();

  runApp(const MaterialApp(home: SplashScreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riders App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const Text("Hello"),
    );
  }
}
