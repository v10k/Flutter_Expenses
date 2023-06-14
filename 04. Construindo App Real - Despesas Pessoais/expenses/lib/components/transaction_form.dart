import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

import './adaptatives/adaptative_button.dart';
import './adaptatives/adaptative_textfield.dart';
import './adaptatives/adaptative_date_picker.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  final void Function(String, String, double, DateTime) onSubmitEditable;
  final Transaction? editableTransaction;

  const TransactionForm(this.onSubmit, this.onSubmitEditable,
      {this.editableTransaction, super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _idController = TextEditingController();
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    (widget.editableTransaction == null)
        ? widget.onSubmit(title, value, _selectedDate)
        : widget.onSubmitEditable(
            _idController.text, title, value, _selectedDate);
  }

  _fillEditableTransaction() {
    if (widget.editableTransaction == null) {
      _idController.text = '';
      return;
    }
    setState(() {
      _idController.text = widget.editableTransaction!.id;
      _titleController.text = widget.editableTransaction!.title;
      _valueController.text =
          widget.editableTransaction!.value.toStringAsFixed(2);
      _selectedDate = widget.editableTransaction!.date;
    });
  }

  @override
  Widget build(BuildContext context) {
    (_idController.text == '') ? _fillEditableTransaction() : '';
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(children: [
            AdaptativeTextField(
              label: 'Título',
              inputController: _titleController,
              inputAction: TextInputAction.next,
            ),
            AdaptativeTextField(
              label: 'Valor (R\$)',
              inputController: _valueController,
              onSubmitted: _submitForm,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            AdaptativeDatePicker(
                selectedDate: _selectedDate,
                selectedEditableDate: (widget.editableTransaction == null) ? null : widget.editableTransaction!.date,
                onDateChanged: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(
                    label: (_idController.text == '')
                        ? 'Nova Transação'
                        : 'Atualizar conta',
                    onPressed: _submitForm)
              ],
            )
          ]),
        ),
      ),
    );
  }
}
