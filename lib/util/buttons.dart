// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  button({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
