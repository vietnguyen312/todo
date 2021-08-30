import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ChangeNotifierProvider(
        create: (_) => TodoHomePageViewModel(),
        child: TodoHomePage(),
      ),
    );
  }
}
