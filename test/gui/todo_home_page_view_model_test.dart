import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/gui/todo_home_page_view_model.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/services/todo_repository.dart';

import 'todo_home_page_view_model_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {

  group('Test updating item state', () {
    late MockTodoRepository repository;
    setUp(() {
      repository = MockTodoRepository();
      when(repository.updateTodoItem(any)).thenAnswer((_) async {});
      GetIt.instance.registerSingleton<TodoRepository>(repository);
    });

    test('test updating item state to completed', () {
      var viewModel = TodoHomePageViewModel();
      TodoItem item = TodoItem(name: 'test', isCompleted: false);
      viewModel.updateState(item);
      expect(item.isCompleted, true);
      expect(verify(repository.updateTodoItem(captureAny)).captured.single.isCompleted, true);
    });

    test('test updating todo item state to uncompleted', () {
      var viewModel = TodoHomePageViewModel();
      TodoItem item = TodoItem(name: 'test', isCompleted: true);
      viewModel.updateState(item);
      expect(item.isCompleted, false);
      expect(verify(repository.updateTodoItem(captureAny)).captured.single.isCompleted, false);
    });

    tearDown(() {
      GetIt.instance.unregister<TodoRepository>();
    });
  });

  group('Test loading items', () {
    setUp(() {
      var repository = MockTodoRepository();
      when(repository.getTodoItems()).thenAnswer((_) async =>
      [
        TodoItem(name: 'First item', isCompleted: false),
        TodoItem(name: 'second item', isCompleted: true),
        TodoItem(name: 'Third item', isCompleted: false),
      ]);
      GetIt.instance.registerSingleton<TodoRepository>(repository);
    });

    test('test items length', () async {
      var viewModel = TodoHomePageViewModel();
      await viewModel.load();
      expect(viewModel.todoItems.length, 3);
      expect(viewModel.incompleteTodoItems.length, 2);
      expect(viewModel.completeTodoItems.length, 1);
    });

    test('Completed items should only contain completed items', () async {
      var viewModel = TodoHomePageViewModel();
      await viewModel.load();
      expect(viewModel.completeTodoItems[0].isCompleted, true);
    });

    test('Incompleted items should only contain incompleted items', () async {
      var viewModel = TodoHomePageViewModel();
      await viewModel.load();
      expect(viewModel.incompleteTodoItems[0].isCompleted, false);
      expect(viewModel.incompleteTodoItems[1].isCompleted, false);
    });

    tearDown(() {
      GetIt.instance.unregister<TodoRepository>();
    });
  });
}
