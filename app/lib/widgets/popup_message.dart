import 'package:flutter/material.dart';

class PopupMessage extends StatelessWidget {
  final String title;
  final String message;

  PopupMessage({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      );

  }
}