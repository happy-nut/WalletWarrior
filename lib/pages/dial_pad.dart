import 'package:flutter/material.dart';

class DialPad extends StatefulWidget {
  final Function(int) numberChanged;

  DialPad({this.numberChanged, Key key}) : super(key: key);

  @override
  _DialPadState createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  final _rowHeight = 72.0;
  int _number = 0;

  void _selectDial(int dial) {
    _number = _number * 10 + dial;
    widget.numberChanged(_number);
  }

  void _clickCancel() {
    _number = 0;
    widget.numberChanged(_number);
  }

  void _clickErase() {
    _number = _number ~/ 10;
    widget.numberChanged(_number);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _rowHeight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      '1',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(1),
                  ),
                  FlatButton(
                    child: Text(
                      '2',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(2),
                  ),
                  FlatButton(
                    child: Text(
                      '3',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(3),
                  ),
                ]),
          ),
          SizedBox(
            height: _rowHeight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      '4',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(4),
                  ),
                  FlatButton(
                    child: Text(
                      '5',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(5),
                  ),
                  FlatButton(
                    child: Text(
                      '6',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(6),
                  ),
                ]),
          ),
          SizedBox(
            height: _rowHeight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      '7',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(7),
                  ),
                  FlatButton(
                    child: Text(
                      '8',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(8),
                  ),
                  FlatButton(
                    child: Text(
                      '9',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(9),
                  ),
                ]),
          ),
          SizedBox(
            height: _rowHeight,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Offstage(
                    offstage: _number == 0,
                    child: FlatButton(
                      child: Text(
                        '취소',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () => _clickCancel(),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      '0',
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () => _selectDial(0),
                  ),
                  Offstage(
                    offstage: _number == 0,
                    child: FlatButton(
                      child: Text(
                        '지우기',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () => _clickErase(),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
