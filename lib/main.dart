import 'package:flutter/material.dart';

import 'package:wallet_warrior/pages/money_flow_input_page.dart';

void main() => runApp(WalletWarrior());

class WalletWarrior extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalletWorrior',
      // TODO(hyungsun, wonjerry): Theme is not yet clear.
      theme: ThemeData(
        primaryColor: Colors.indigo[400],
        buttonColor: Colors.indigo[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          display2: TextStyle(fontSize: 45.0),
          display1: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
          headline: TextStyle(fontSize: 24.0),
          title: TextStyle(
              fontSize: 21.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
          body1: TextStyle(fontSize: 16.0, color: Colors.black54),
          button: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ),
      // TODO(hyungsun): Wrap below with proper wrapper. maybe tab bar?
      // TODO(hyungsun): Consider localization.
      home: MoneyFlowInputPage(title: '수입/지출'),
    );
  }
}
