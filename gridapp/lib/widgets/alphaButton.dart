import 'package:flutter/material.dart';

class AlphaButton extends StatelessWidget {
  bool isCircle = false;
  final bool gameStart;
  final String alphabet;
  final bool errorOccur;
  AlphaButton(this.alphabet, this.isCircle, this.gameStart, this.errorOccur,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: gameStart
              ? isCircle && !errorOccur
                  ? Colors.green[300]
                  : Colors.red
              : Colors.blue[100],
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
