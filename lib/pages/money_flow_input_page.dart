import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:wallet_warrior/pages/dial_pad.dart';

class MoneyFlowInputPage extends StatefulWidget {
  MoneyFlowInputPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MoneyFlowInputPageState createState() => _MoneyFlowInputPageState();
}

enum InputStage { money, date, category }

class _MoneyFlowInputPageState extends State<MoneyFlowInputPage> {
  static final _titles = ['수입/지출액 입력', '날짜 입력', '카테고리 입력'];

  // TODO(wonjerry): Get categories from google spread sheet.
  static final dropdownItems = [
    '투자',
    '대출 이자 및 상환',
    '저축',
    '보험',
    '세금',
    '식사',
    '문화생활',
    '교통비',
    '통신비',
    '게임',
    '사무용품',
    '기타 지출',
    '월급',
    '대출',
    '기타 수입'
  ];
  InputStage _currentStage = InputStage.money;
  String _dialTitle = "0";

  int _inputAmount = 0;
  DateTime _inputDate = DateTime.now();
  String _inputCategory = dropdownItems[0];

  Widget _confirmButton() {
    return SizedBox(
      height: 46,
      width: 120,
      child: RaisedButton(
          elevation: 4.0,
          color: Theme.of(context).buttonColor,
          child: Text(
            '확인',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
          onPressed: _goToNextStage),
    );
  }

  Future _selectDate(BuildContext context) async {
    final thisYear = DateTime.now().year;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _inputDate,
        firstDate: DateTime(thisYear - 3),
        lastDate: DateTime(thisYear + 3));
    if (picked == null || picked == _inputDate) {
      return;
    }

    setState(() {
      _inputDate = picked;
    });
  }

  void _updateNumber(int number) {
    _inputAmount = number;
    setState(() {
      _dialTitle = _inputAmount.toString();
    });
  }

  void _goToNextStage() {
    switch (_currentStage) {
      case InputStage.money:
        setState(() {
          _currentStage = InputStage.date;
        });
        break;
      case InputStage.date:
        setState(() {
          _currentStage = InputStage.category;
        });
        break;
      case InputStage.category:
        // TODO(hyugnsun): Handle this case.
        return;
    }
  }

  String _getSelectedDateDisplayString() {
    return DateFormat('yyyy.MM.dd').format(_inputDate);
  }

  Widget _buildMoneyInput() {
    double _opacity = 0.0;
    if (_dialTitle != '0') {
      _opacity = 1.0;
    }

    return Offstage(
      offstage: _currentStage != InputStage.money,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text(
              '$_dialTitle 원',
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          DialPad(numberChanged: _updateNumber),
          Opacity(
            opacity: _opacity,
            child: Center(child: _confirmButton()),
          )
        ],
      ),
    );
  }

  Widget _buildDateInput() {
    return Offstage(
        offstage: _currentStage != InputStage.date,
        child: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text(
                  _getSelectedDateDisplayString(),
                  style: Theme.of(context).textTheme.display2,
                ),
                onPressed: () => _selectDate(context),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: _confirmButton(),
              ),
            ],
          ),
        ));
  }

  Widget _buildCategoryInput() {
    return Offstage(
      offstage: _currentStage != InputStage.category,
      child: Column(
        children: <Widget>[
          DropdownButton(
            value: _inputCategory,
            items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValue) {
              setState(() {
                _inputCategory = newValue;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: _confirmButton(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "${_titles[_currentStage.index]}",
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildMoneyInput(),
                    _buildDateInput(),
                    _buildCategoryInput(),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
