import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime? selectedEditableDate;

  const AdaptativeDatePicker(
      {required this.selectedDate,
      required this.onDateChanged,
      this.selectedEditableDate,
      super.key});
  final Function(DateTime) onDateChanged;

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: (selectedEditableDate == null)
          ? DateTime.now()
          : selectedEditableDate!,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2021),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
          )
        : Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        height: mediaQuery.height * 0.06,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          mini: true,
          child: Icon(
            Icons.date_range,
            size: 25,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => _showDatePicker(context),
        ),
      ),
    );
  }
}
