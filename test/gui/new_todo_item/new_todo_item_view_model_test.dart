import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/gui/new_todo_item/new_todo_item_view_model.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/services/todo_repository.dart';

import 'new_todo_item_view_model_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  group('Test adding new todo item', () {
    late MockTodoRepository repository;
    setUp(() {
      repository = MockTodoRepository();
      when(repository.add(any)).thenAnswer((_) async {
        return TodoItem(name: '');
      });
      GetIt.instance.registerSingleton<TodoRepository>(repository);
    });

    test('Test adding new todo item', () async {
      var viewModel = NewTodoItemViewModel();
      await viewModel.add('Todo');
      verify(repository.add(any)).called(1);
      expect(viewModel.todoItem, isNotNull);
    });

    tearDown(() {
      GetIt.instance.unregister<TodoRepository>();
    });
  });
}
