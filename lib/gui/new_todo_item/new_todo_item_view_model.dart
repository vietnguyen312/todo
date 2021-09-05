import 'package:flutter/cupertino.dart';
import 'package:todo/configurations/service_configuration.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/services/todo_repository.dart';
import 'package:flutter/foundation.dart';

class NewTodoItemViewModel with ChangeNotifier {
  TodoRepository repository = ServiceConfiguration.instance.todoRepository;
  TodoItem? _todoItem;

  TodoItem? get todoItem => _todoItem;

  NewTodoItemViewModel();

  Future add(String todo) async {
    _todoItem = await repository.add(todo);
    notifyListeners();
  }
}