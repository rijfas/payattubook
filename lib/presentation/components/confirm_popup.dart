import 'package:flutter/material.dart';

class ConfirmPopup extends StatelessWidget {
  const ConfirmPopup({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: Text(message),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Cancell'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ElevatedButton(
          child: const Text('Confirm'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
