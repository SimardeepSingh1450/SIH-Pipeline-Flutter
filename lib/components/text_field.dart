import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final bool obscureText;
  final String hintText;

  MyTextField(
      {super.key,
      required this.controller,
      required this.obscureText,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText),
      ),
    );
  }
}
