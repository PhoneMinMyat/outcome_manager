import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import 'char_table.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get chartData {
    return List.generate(
      7,
      (index) {
        var weekDay = DateTime.now().subtract(Duration(days: index));

        double totalSum = 0;
        for (var i = 0; i < recentTransaction.length; i++) {
          if (recentTransaction[i].dateTime.day == weekDay.day &&
              recentTransaction[i].dateTime.month == weekDay.month &&
              recentTransaction[i].dateTime.year == weekDay.year) {
            totalSum += recentTransaction[i].amount;
          }
        }

        return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
      },
    ).reversed.toList();
  }

  double get maxSpending {
    return chartData.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: chartData.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartTable(
                  data['day'].toString().substring(0, 1),
                  (data['amount'] as double),
                  maxSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
