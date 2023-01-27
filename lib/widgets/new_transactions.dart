import 'package:flutter/material.dart';

class NewTransactions extends StatelessWidget {
  final Function addNewTrans;

  final titleController = TextEditingController();
  final amountContorller = TextEditingController();

  NewTransactions({super.key, required this.addNewTrans});

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountContorller.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    addNewTrans(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountContorller,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
                onPressed: () {
                  submitData;
                },
                child: const Text(
                  'Add Transactions',
                  style: TextStyle(color: Colors.purple),
                ))
          ],
        ),
      ),
    );
  }
}
