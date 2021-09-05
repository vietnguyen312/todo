import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/configurations/service_configuration.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/services/todo_repository.dart';

class TodoHomePageViewModel with ChangeNotifier {
  TodoRepository repository = ServiceConfiguration.instance.todoRepository;
  List<TodoItem>? _todoItems;

  List<TodoItem> get todoItems => UnmodifiableListView(_todoItems ?? []);

  List<TodoItem> get incompleteTodoItems => UnmodifiableListView(_todoItems?.where((item) => !item.isCompleted) ?? []);

  List<TodoItem> get completeTodoItems => UnmodifiableListView(_todoItems?.where((item) => item.isCompleted) ?? []);

  TodoHomePageViewModel();

  Future<void> load() async {
    _todoItems = await repository.getTodoItems();
    notifyListeners();
  }

  void insertTodoItem(TodoItem todoItem) {
    _todoItems ??= [];
    _todoItems!.insert(0, todoItem);
    notifyListeners();
  }

  void updateState(TodoItem todoItem) {
    todoItem.isCompleted = !todoItem.isCompleted;
    repository.updateTodoItem(todoItem);
    notifyListeners();
  }
}
