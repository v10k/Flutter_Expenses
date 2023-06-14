import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  
  final String label;
  final TextEditingController inputController;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final void Function()? onSubmitted;
  
  const AdaptativeTextField(
      {required this.label,
      required this.inputController,
      this.inputAction,
      this.keyboardType,
      this.onSubmitted,
      super.key});



  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CupertinoTextField(
            controller: inputController,
            textInputAction: inputAction,
            keyboardType: keyboardType,
            onSubmitted: (_) => onSubmitted,
            placeholder: label,
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 12,
            ),
          ),
        )
        : TextField(
            controller: inputController,
            textInputAction: inputAction,
            keyboardType: keyboardType,
            onSubmitted: (_) => onSubmitted,
            decoration: InputDecoration(
              labelText: label,
            ),
          );
  }
}
