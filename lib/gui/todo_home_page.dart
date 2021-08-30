import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo application'),
      ),
      body: Center(
        child: Text('Todo Home Page'),
      ),
    );
  }
}