import 'package:flutter/material.dart';

class Utilies {
  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static const chatBubbleCollection = "message";
}
