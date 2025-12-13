import 'package:flutter/material.dart';

class BuildElevatedButton extends StatelessWidget {
  const BuildElevatedButton({
    super.key,
    required this.textOfElevatedButton,
    required this.onPressed,
  });
  final String textOfElevatedButton;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(fixedSize: Size(380, 50)),
      child: Text(
        textOfElevatedButton,
        style: TextStyle(
          color: const Color.fromARGB(255, 13, 59, 137),
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
