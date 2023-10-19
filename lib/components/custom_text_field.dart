import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  final String? label;
  bool? isObsecre = true;
  bool? enabled = true;

  CustomTextField({
    Key? key,
    this.controller,
    this.data,
    this.enabled,
    this.hintText,
    this.isObsecre,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            controller: controller,
            obscureText: isObsecre!,
            style: const TextStyle(color: Colors.black87),
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: Icon(data, color: const Color(0xff5ac18e)),
              hintStyle: const TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }
}
