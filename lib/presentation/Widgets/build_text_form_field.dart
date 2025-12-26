import 'package:flutter/material.dart';

class BuildTextFormField extends StatelessWidget {
  const BuildTextFormField({
    super.key,
    required this.labelText,
    required this.onChanged,
    required this.bordersColor,
    this.suffixIcon,
    this.validator,
    this.hintText,
  });
  final String labelText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color bordersColor;
  final Widget? suffixIcon;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(fontSize: 20, color: bordersColor),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: bordersColor, fontSize: 20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 3, color: bordersColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 3, color: bordersColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(width: 3, color: bordersColor),
        ),
      ),
    );
  }
}
