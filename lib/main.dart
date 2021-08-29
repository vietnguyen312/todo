import 'package:flutter/material.dart';
import 'package:todo/theme/custom_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo application',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo application'),
        ),
        body: Center(
          child: Text('Todo Home Page'),
        ),
      ),
    );
  }
}
