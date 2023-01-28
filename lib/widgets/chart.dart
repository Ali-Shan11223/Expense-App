import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Chart extends StatefulWidget {
  Chart({super.key, required this.recentTransaction});

  List<Transaction> recentTransaction;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var i = 0; i < widget.recentTransaction.length; i++) {
        if (widget.recentTransaction[i].date.day == weekDay.day &&
            widget.recentTransaction[i].date.month == weekDay.month &&
            widget.recentTransaction[i].date.year == weekDay.year) {
          totalSum += widget.recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum.toStringAsFixed(2)
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + double.parse('${item['amount']}');
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                label: data['day'].toString(),
                spendingAmount: double.parse('${data['amount']}'),
                spendingAmountPer: totalSpending == 0.0
                    ? 0.0
                    : double.parse('${data['amount']}') / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
