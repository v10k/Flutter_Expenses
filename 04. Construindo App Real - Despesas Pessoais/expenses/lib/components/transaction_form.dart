import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, this.onSubmitEditable,
      {this.editableTransaction, super.key});

  final void Function(String, double, DateTime) onSubmit;
  final void Function(String, String, double, DateTime) onSubmitEditable;
  final Transaction? editableTransaction;

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

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: (widget.editableTransaction == null)
          ? DateTime.now()
          : widget.editableTransaction!.date,
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      locale: const Locale('pt', 'BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    (_idController.text == '') ? _fillEditableTransaction() : '';
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: _titleController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            controller: _valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitForm(),
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                    child: Text(
                        'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}')),
                TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary),
                    onPressed: _showDatePicker,
                    child: const Text('Selecionar Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _submitForm,
                child: (_idController.text == '')
                    ? Text(
                        'Nova Transação',
                      )
                    : Text('Atualizar conta'),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
