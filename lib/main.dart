import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/configurations/dependency_configuration.dart';
import 'package:todo/gui/todo_home_page.dart';
import 'package:todo/gui/todo_home_page_view_model.dart';
import 'package:todo/theme/custom_theme.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo application',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      home: ChangeNotifierProvider(
        create: (_) => TodoHomePageViewModel(),
        child: TodoHomePage(),
      ),
    );
  }
}
