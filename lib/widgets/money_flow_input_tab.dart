import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_warrior/widgets/dial_pad.dart';
import 'package:wallet_warrior/widgets/rounded_button.dart';

class MoneyFlowInputTab extends StatefulWidget {
  MoneyFlowInputTab({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MoneyFlowInputTabState createState() => _MoneyFlowInputTabState();
}

enum InputStage { money, date, category }

class _MoneyFlowInputTabState extends State<MoneyFlowInputTab> {
  // TODO(wonjerry): Get categories from google spread sheet.
  static final _dropdownItems = [
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
  int _amount = 0;
  DateTime _inputDate = DateTime.now();
  String _inputCategory = _dropdownItems.first;

  Future<void> _selectDate() async {
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

  String getStageTitle(InputStage stage) {
    switch (stage) {
      case InputStage.money:
        return widget.title;
      case InputStage.date:
        return '날짜 입력';
      case InputStage.category:
        return '카테고리 입력';
    }

    assert(false);
    return null;
  }

  void onNumberConfirmed(int number) {
    _amount = number;
    _goToNextStage();
  }

  Widget _buildMoneyInput() {
    return Offstage(
      offstage: _currentStage != InputStage.money,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DialPad(onNumberConfirmed: onNumberConfirmed),
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
              onPressed: _selectDate,
            ),
            const SizedBox(height: 48.0),
            RoundedButton(onPressed: _goToNextStage),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryInput() {
    return Offstage(
      offstage: _currentStage != InputStage.category,
      child: Column(
        children: <Widget>[
          DropdownButton(
            value: _inputCategory,
            onChanged: (newValue) {
              setState(() {
                _inputCategory = newValue;
              });
            },
            items: _dropdownItems.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 48.0),
          RoundedButton(onPressed: _goToNextStage)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            getStageTitle(_currentStage),
            style: Theme.of(context).textTheme.display1,
          ),
          const SizedBox(height: 64.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildMoneyInput(),
                _buildDateInput(),
                _buildCategoryInput(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
