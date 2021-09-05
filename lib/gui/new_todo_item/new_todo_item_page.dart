import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/gui/new_todo_item/new_todo_item_view_model.dart';

class NewToDoItemPage extends StatefulWidget {
  const NewToDoItemPage({Key? key}) : super(key: key);

  @override
  _NewTodoItemPageState createState() => _NewTodoItemPageState();
}

class _NewTodoItemPageState extends State<NewToDoItemPage> {
  TextEditingController _newTaskTextEditingController = new TextEditingController();
  bool _hasEnteredTodo = false;

  @override
  void initState() {
    super.initState();
    _newTaskTextEditingController.addListener(() {
      if (_newTaskTextEditingController.text.isEmpty && _hasEnteredTodo) {
        setState(() {
          _hasEnteredTodo = false;
        });
      } else if (_newTaskTextEditingController.text.isNotEmpty && !_hasEnteredTodo) {
        setState(() {
          _hasEnteredTodo = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _newTaskTextEditingController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enterTaskHint,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                maxLines: 5,
                autofocus: true,
                textInputAction: TextInputAction.done,
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: !_hasEnteredTodo ? null : () {
                  context.read<NewTodoItemViewModel>().add(_newTaskTextEditingController.text);
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newTaskTextEditingController.dispose();
    super.dispose();
  }
}
