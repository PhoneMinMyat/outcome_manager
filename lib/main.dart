import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/user_transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MoneyManager(),
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Color(0xff042a2b),
        colorScheme: ColorScheme.dark().copyWith(
          primary: Colors.red,
          secondary: Color(0xff042a2b),
        ),
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(color: Colors.white, fontSize: 30),
              subtitle1: TextStyle(color: Colors.black, fontSize: 20),
              subtitle2: TextStyle(color: Colors.white, fontSize: 20),
              button: TextStyle(color: Colors.white),
            ),
      ),
    );
  }
}

class MoneyManager extends StatefulWidget {
  @override
  _MoneyManagerState createState() => _MoneyManagerState();
}

class _MoneyManagerState extends State<MoneyManager>
    with WidgetsBindingObserver {
  final List<Transaction> _userTransaction = [];
  bool _showChartBar = true;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  final appBar = AppBar(
    title: Text('Expense Tracker'),
    // actions: [
    //   IconButton(
    //       onPressed: () => startAddNewTransaction(context),
    //       icon: Icon(Icons.add))
    // ],
  );

  void _inputNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final tempTransaction = Transaction(
        title: txTitle,
        amount: txAmount,
        dateTime: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransaction.add(tempTransaction);
    });

    print('added');
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (BuildContext ctx) {
        return UserTransaction(_inputNewTransaction);
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransaction
        .where(
          (element) => element.dateTime.isAfter(
            DateTime.now().subtract(Duration(days: 7)),
          ),
        )
        .toList();
  }

  void removeTran(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> _buildLandScapeContent(Widget tranList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart Bar',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Switch(
              activeColor: Theme.of(context).primaryColor,
              value: _showChartBar,
              onChanged: (val) {
                setState(() {
                  _showChartBar = val;
                });
              }),
        ],
      ),
      _showChartBar
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : tranList
    ];
  }

  List<Widget> _buildPortraitContent(Widget tranList) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      tranList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final tranList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          1,
      child: TransactionList(_userTransaction, removeTran),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isLandScape) ..._buildLandScapeContent(tranList),
                if (!isLandScape) ..._buildPortraitContent(tranList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
