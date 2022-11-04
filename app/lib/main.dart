import 'package:flutter/material.dart';
import 'package:medio/views/MainView.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medio',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MainView(),
    );
  }
}
