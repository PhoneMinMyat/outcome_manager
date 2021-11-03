import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required Transaction userTransaction,
    required this.removeTransaction,
  }) : _userTransaction = userTransaction, super(key: key);

  final Transaction _userTransaction;
  final Function removeTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                  '\$${_userTransaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(_userTransaction.title),
        subtitle: Text(
          DateFormat.yMMMEd()
              .format(_userTransaction.dateTime),
        ),
        trailing: IconButton(
          onPressed: () =>
              removeTransaction(_userTransaction.id),
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
