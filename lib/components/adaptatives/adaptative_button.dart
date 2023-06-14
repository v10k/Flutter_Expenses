import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton(
      {required this.label, required this.onPressed, this.tema, super.key});

  final String label;
  final ButtonStyle? tema;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 10,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleLarge,
            ));
  }
}
