import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  dynamic Function()? onTap;

  MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 239, 125, 125),
                Color.fromARGB(255, 140, 201, 234)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )),
        child: Center(
            child: Text(
          "Sign In",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
