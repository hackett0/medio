import 'package:flutter/material.dart';
import 'package:medio/views/HomeView.dart';
import 'package:medio/views/MineView.dart';
import 'package:medio/views/MetaView.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    MetaView(),
    Mine(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  static const List<String> _titleOptions = <String>['推荐', '资料库', '设置'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(_titleOptions[_selectIndex]),
        centerTitle: true,
        shadowColor: Colors.transparent,
      ),
      body: _widgetOptions.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '推荐',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: '资料库',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onTap,
      ),
    );
  }
}
