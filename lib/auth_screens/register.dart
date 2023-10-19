import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:driver_cargo/auth_screens/login.dart';
import 'package:driver_cargo/components/custom_text_field.dart';
import 'package:driver_cargo/components/error_dialog.dart';
import 'package:driver_cargo/components/header_widget.dart';
import 'package:driver_cargo/components/loading_dialog.dart';
import 'package:driver_cargo/screens/home_screen.dart';
import 'package:driver_cargo/services/authService.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
// import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
// import '../screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

//image picker
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

//location
  Position? position;
  List<Placemark>? placeMarks;

//address name variable
  String completeAddress = "";

//seller image url
  String sellerImageUrl = "";

//function for getting current location
  Future<Position?> getCurrenLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    position = newPosition;

    placeMarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );

    Placemark pMark = placeMarks![0];

    completeAddress =
        '${pMark.thoroughfare}, ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea}, ${pMark.country}';

    locationController.text = completeAddress;
    return null;
  }

//Form Validation
  Future<void> signUpFormValidation() async {
    //checking if user selected image

    if (passwordController.text == confirmpasswordController.text) {
      //nested if (cheking if controllers empty or not)
      if (confirmpasswordController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty) {
        //start uploading image
        showDialog(
          context: context,
          builder: (c) {
            return const LoadingDialog(
              message: "Registering Account",
            );
          },
        );
        registerNow();
      } else {
        showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please fill the required info for Registration. ",
            );
          },
        );
      }
    } else {
      //show an error if passwords do not match
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: "Password do not match",
          );
        },
      );
    }
  }

  registerNow() async {
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(
          message: "Checking Credentials...",
        );
      },
    );

    Auth user = Auth();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String username = nameController.text.trim();
    String cellPhoneNumber = phoneController.text.trim();
    int statusCode = await user.RegisterUser(
        email: email,
        password: password,
        username: username,
        cellPhoneNumber: cellPhoneNumber);

    if (statusCode == 201) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => const LoginScreen(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: "Failed to login.",
          );
        },
      );
    }
  }

  Widget buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          "SUBMIT",
          style: TextStyle(
              color: Color(0xff5ac18e),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          signUpFormValidation();
        },
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen())),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "Already have an account? ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: "Sign in",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Color(0x665ac18e),
                        Color(0x995ac18e),
                        Color(0xcc5ac18e),
                        Color(0xff5ac18e)
                      ])),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 60),
                    child: Column(
                      children: [
                        const Text(
                          "Driver's Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                data: Icons.person,
                                controller: nameController,
                                hintText: "Full Name",
                                isObsecre: false,
                                label: "Full Name",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                data: Icons.email,
                                controller: emailController,
                                hintText: "Email",
                                isObsecre: false,
                                label: "Email",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                data: Icons.phone_android_outlined,
                                controller: phoneController,
                                hintText: "Phone nummber",
                                isObsecre: false,
                                label: "Phone Number",
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                data: Icons.lock,
                                controller: passwordController,
                                hintText: "Password",
                                label: "Password",
                                isObsecre: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                data: Icons.lock,
                                controller: confirmpasswordController,
                                hintText: "Confirm password",
                                isObsecre: true,
                                label: "Confirm Password",
                              ),
                              buildSignUpBtn(),
                              buildLoginBtn(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
