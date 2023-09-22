import 'package:flutter/material.dart';

import '../../config/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primary,
  });

  final String text;
  final Function() onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(color), // Set button background color
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Set button border radius
          ),
        ),
      ),
      onPressed: onPressed, // Set button onPressed function
      child: Text(text), // Set button text
    );
  }
}
