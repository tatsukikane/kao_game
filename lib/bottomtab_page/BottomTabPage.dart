import 'package:flutter/material.dart';

import '../img_list/img_list_page.dart';
import '../mypage/my_page.dart';
import '../ranking_page/ranking_page.dart';
import '../topic_page/topic_page.dart';
import '../widgets/thider_top.dart';

class BottomTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState();
  }
}

class _BottomTabPageState extends State<BottomTabPage> {

  int _currentIndex = 0;
  final _pageWidgets = [
    TopicPage(),
    ThiderTop(),
    RankingPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'お題'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: '投票'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'ランキング'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Mypage'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}