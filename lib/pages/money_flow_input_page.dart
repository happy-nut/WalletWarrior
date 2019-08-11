import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:wallet_warrior/pages/dial_pad.dart';

class MoneyFlowInputPage extends StatefulWidget {
  MoneyFlowInputPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MoneyFlowInputPageState createState() => _MoneyFlowInputPageState();
}

class _MoneyFlowInputPageState extends State<MoneyFlowInputPage> {
  static final titles = ['수입/지출액 입력', '날짜 입력', '카테고리 입력'];

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
  int stage = 0;
  String dialTitle = "0";

  int amount = 0;
  DateTime selectedDate = DateTime.now();
  String selectedCategory = dropdownItems[0];

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

  Future<Null> _selectDate(BuildContext context) async {
    final thisYear = DateTime.now().year;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(thisYear - 3),
        lastDate: DateTime(thisYear + 3));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _updateNumber(int number) {
    amount = number;
    setState(() {
      dialTitle = amount.toString();
    });
  }

  _goToNextStage() {
    if (stage == 2) {
      // TODO(hyugnsun): Handle this.
      return;
    }
    setState(() {
      stage++;
    });
  }

  _getSelectedDateDisplayString() {
    return DateFormat('yyyy.MM.dd').format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 64.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${titles[stage]}",
                      style: Theme.of(context).textTheme.display1,
                    ),
                  ],
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Offstage(
                      offstage: stage != 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Center(
                            child: Text(
                              '$dialTitle 원',
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ),
                          DialPad(numberChanged: _updateNumber),
                          Offstage(
                            offstage: dialTitle == '0',
                            child: Center(child: _confirmButton()),
                          )
                        ],
                      ),
                    ),
                    Offstage(
                        offstage: stage != 1,
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
                        )),
                    Offstage(
                      offstage: stage != 2,
                      child: Column(
                        children: <Widget>[
                          DropdownButton(
                            value: selectedCategory,
                            items: dropdownItems
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String newValue) {
                              setState(() {
                                selectedCategory = newValue;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 48.0),
                            child: _confirmButton(),
                          )
                        ],
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ]),
    );
  }
}
