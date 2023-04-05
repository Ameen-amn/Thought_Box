import 'package:flutter/material.dart';

class AlphaButton extends StatelessWidget {
  bool isCircle = false;
  String alphabet;
  AlphaButton(this.alphabet, this.isCircle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[100],
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle),
      child: Center(
        child: Text(
          alphabet,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
