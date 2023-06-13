import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final void Function(Transaction editable) onEditable;

  const TransactionList(this.transactions, this.onRemove, this.onEditable,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  Text('Nenhuma Transação Cadastrada!',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${tr.value}'),
                      ),
                    ),
                  ),
                  title: Text(tr.title,
                      style: Theme.of(context).textTheme.titleLarge),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? Wrap(
                          children: [
                            TextButton.icon(
                              onPressed: () => onEditable(tr),
                              icon: const Icon(Icons.edit),
                              label: const Text('Editar'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.outline),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => onRemove(tr.id),
                              icon: const Icon(Icons.delete),
                              label: const Text('Excluir'),
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.error),
                              ),
                            ),
                          ],
                        )
                      : Wrap(children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Theme.of(context).colorScheme.outline,
                            onPressed: () => onEditable(tr),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (await confirm(context,
                                  content: const Text(
                                    "Realmente deseja remover?",
                                  ))) {
                                onRemove(tr.id);
                              }
                            },
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ]),
                ),
              );
            },
          );
  }
}
