import 'package:flutter/material.dart';
import 'package:wallet_warrior/widgets/profile_tab.dart';
import 'package:wallet_warrior/widgets/money_flow_input_tab.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Widget> _children = [
    MoneyFlowInputTab(title: '수입/지출 입력'),
    ProfileTab(title: '프로필')
  ];

  int _currentTab = 0;
  
  void onTabPressed(int tab) {
    setState(() {
      _currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _children[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabPressed,
        currentIndex: _currentTab,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.attach_money),
            title: new Text('Money-flow'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      ),
    );
  }
}
