import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;

  RoundedButton({this.onPressed, Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      width: 120,
      child: RaisedButton(
          elevation: 4.0,
          color: Theme.of(context).buttonColor,
          child: Text(
            '확인',
            style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white,
            ),
          ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
          onPressed: onPressed),
    );
  }
}
