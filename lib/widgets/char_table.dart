import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartTable extends StatelessWidget {
  final String label;
  final double spendingAmout;
  final double spendingPrctOfTotalAmount;

  ChartTable(this.label, this.spendingAmout, this.spendingPrctOfTotalAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.125,
              child: FittedBox(
                  child: Text('\$ ${spendingAmout.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.65,
            width: 15,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: (spendingPrctOfTotalAmount),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.125,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
