import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField(
      {required this.label,
      required this.inputController,
      this.inputAction,
      this.keyboardType,
      this.onSubmitted,
      super.key});

  final String label;
  final TextEditingController inputController;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
          controller: inputController,
          textInputAction: inputAction,
          keyboardType: keyboardType,
          onSubmitted: onSubmitted,
          placeholder: label,
        )
        : TextField(
            controller: inputController,
            textInputAction: inputAction,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
