import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  final void Function(Transaction editable) onEditable;

  const TransactionList(this.transactions, this.onRemove, this.onEditable, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 20),
                Text('Nenhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                    trailing: Wrap(children: [
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
            ),
    );
  }
}
