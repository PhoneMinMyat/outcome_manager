import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UserTransaction extends StatefulWidget {
  final Function addTx;

  UserTransaction(this.addTx){
    print('Constructor UserTransaction Widget');
  }

  @override
  _UserTransactionState createState() {
    print('create State UserTransaction Widget');
    return _UserTransactionState();
  }
}

class _UserTransactionState extends State<UserTransaction> {
  @override
  void initState() {
    super.initState();
    print('init()');
  }
  
  @override
  void didUpdateWidget (UserTransaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
    
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDateTime = DateTime(1970);

  bool isSelectedDate = false;

  void _submitTx() {
    final inputTitile = titleController.text;
    final inputAmount = double.parse(amountController.text);

    if (inputTitile.isEmpty || inputAmount <= 0 || isSelectedDate == false) {
      return;
    }

    widget.addTx(
      inputTitile,
      inputAmount,
      _selectedDateTime,
    );
    titleController.clear();
    amountController.clear();
    isSelectedDate = false;
    _selectedDateTime = DateTime(1980);

    Navigator.of(context).pop();
  }

  void _openDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then(
      (selectedDate) {
        if (selectedDate == null) {
          return;
        }

        setState(
          () {
            _selectedDateTime = selectedDate;
            isSelectedDate = true;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              15, 15, 15, MediaQuery.of(context).viewInsets.bottom + 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _submitTx(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                onSubmitted: (_) => _submitTx(),
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(isSelectedDate
                        ? DateFormat.yMd().format(_selectedDateTime)
                        : 'No Date Picked'),
                    TextButton(
                        onPressed: _openDateTimePicker,
                        child: Text(
                          'Pick A Date',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ))
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitTx,
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor),
                child: Text(
                  'add transaction',
                  style: Theme.of(context).textTheme.button,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
