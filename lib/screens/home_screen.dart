import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/new_transactions.dart';
import '../widgets/transactions_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: '1', title: 'New Laptop', amount: 90.99, date: DateTime.now()),
    Transaction(
        id: '2', title: 'New Clothes', amount: 40.56, date: DateTime.now())
  ];

  void _newTransaction(String title, double amount) {
    final newTrans = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTrans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.blue,
                child: Text('CHART!'),
              ),
            ),
            NewTransactions(
              addNewTrans: _newTransaction,
            ),
            TransactionsList(
              transactions: _userTransactions,
            )
          ],
        ),
      ),
    );
  }
}
