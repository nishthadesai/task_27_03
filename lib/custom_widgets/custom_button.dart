import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final ButtonStyle buttonStyle;
  final Widget child;
  const CustomButton(
      {super.key,
      required this.child,
      required this.onPressed,
      required this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          onPressed();
        },
        child: child);
  }
}
