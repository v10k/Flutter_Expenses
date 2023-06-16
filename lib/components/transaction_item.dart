import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final void Function(Transaction editable) onEditable;
  final void Function(String p1) onRemove;

  const TransactionItem({
    super.key,
    required this.tr,
    required this.onEditable,
    required this.onRemove,
  });

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${widget.tr.value}'),
            ),
          ),
        ),
        title: Text(widget.tr.title,
            style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? Wrap(
                children: [
                  TextButton.icon(
                    onPressed: () => widget.onEditable(widget.tr),
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.outline),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => widget.onRemove(widget.tr.id),
                    icon: const Icon(Icons.delete),
                    label: const Text('Excluir'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.error),
                    ),
                  ),
                ],
              )
            : Wrap(children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => widget.onEditable(widget.tr),
                ),
                IconButton(
                  onPressed: () async {
                    if (await confirm(context,
                        content: const Text(
                          "Realmente deseja remover?",
                        ))) {
                      widget.onRemove(widget.tr.id);
                    }
                  },
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).colorScheme.error,
                ),
              ]),
      ),
    );
  }
}
