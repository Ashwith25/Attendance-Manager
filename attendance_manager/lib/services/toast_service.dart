import 'package:flutter/material.dart';

class ToastService {
  static void showToast(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.grey[700],
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          textColor: Colors.redAccent,
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          },
        ),
      ),
    );
  }
}