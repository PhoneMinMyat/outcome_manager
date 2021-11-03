import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;

  final Function removeTransaction;

  TransactionList(this._userTransaction, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTransaction.isEmpty
        ? LayoutBuilder(builder: (context, con) {
            return Column(
              children: [
                Text(
                  'No transaction is added',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: con.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: _userTransaction.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                  userTransaction: _userTransaction[index],
                  removeTransaction: removeTransaction);
            },
          );
  }
}
