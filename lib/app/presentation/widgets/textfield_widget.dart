import 'package:flutter/material.dart';

import '../../config/colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.label, // The label text for the text field
    required this.hint, // The hint text for the text field
    this.action, // The action to take when the text field is submitted
    this.enabled = true, // Whether the text field is enabled or not
    this.initialValue, // The initial value for the text field
    this.controller, // The controller for the text field
    this.suffixIcon, // The icon to display at the end of the text field
    this.keyboardType, // The type of keyboard to use for the text field
    this.obscureText =
        false, // Whether the text field should obscure the entered text or not
  });

  final String label;
  final String hint;
  final TextInputAction? action;
  final bool enabled;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // The controller for the text field
      initialValue: initialValue, // The initial value for the text field
      keyboardType:
          keyboardType, // The type of keyboard to use for the text field
      obscureText:
          obscureText, // Whether the text field should obscure the entered text or not
      enabled: enabled, // Whether the text field is enabled or not
      autocorrect: false,
      textInputAction: action ??
          TextInputAction
              .next, // The action to take when the text field is submitted
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        labelText: label, // The label text for the text field
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.secondary,
            ),
        hintText: hint, // The hint text for the text field
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.hint,
            ),
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon:
            suffixIcon, // The icon to display at the end of the text field
      ),
    );
  }
}
