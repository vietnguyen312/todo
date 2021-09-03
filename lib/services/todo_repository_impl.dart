import 'dart:ffi';

import 'package:todo/model/todo_item.dart';
import 'package:todo/services/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {

  @override
  Future<List<TodoItem>> getTodoItems() {
    return Future.value(<TodoItem>[
      TodoItem(name: 'First one'),
      TodoItem(name: 'SSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneSecond oneecond one', isCompleted: true),
      TodoItem(name: 'Third one'),
    ]);
  }

  @override
  Future updateTodoItem(TodoItem item) {
    return Future.value(Void);
  }
}