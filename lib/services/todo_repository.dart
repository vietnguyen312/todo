import 'package:todo/model/todo_item.dart';

abstract class TodoRepository {
  Future<List<TodoItem>> getTodoItems();
  Future updateTodoItem(TodoItem item);
  Future<TodoItem> add(String todo);
}