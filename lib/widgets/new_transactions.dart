import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addNewTrans;

  const NewTransactions({super.key, required this.addNewTrans});

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountContorller = TextEditingController();
  DateTime? selectedDate;

  void _submitData() {
    if (_amountContorller.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountContorller.text);
    if (enteredTitle.isEmpty || enteredAmount! <= 0 || selectedDate == null) {
      return;
    }
    widget.addNewTrans(enteredTitle, enteredAmount, selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1999),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        selectedDate = pickedDate!;
      });
    });
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
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountContorller,
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(selectedDate == null
                      ? 'No date selected!'
                      : 'Selected date: ${DateFormat.yMd().format(selectedDate!)}'),
                ),
                TextButton(
                  onPressed: () {
                    _datePicker();
                  },
                  child: const Text(
                    'Select Date',
                  ),
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  _submitData();
                },
                child: const Text('Add Transactions'))
          ],
        ),
      ),
    );
  }
}
