import 'package:flutter_test/flutter_test.dart';
import 'package:todo/configurations/dependency_configuration.dart';
import 'package:todo/gui/todo_home_page_view_model.dart';
import 'package:todo/model/todo_item.dart';

void main() {

  group('Test updating item state', () {
    configureDependencies();
    var viewModel = TodoHomePageViewModel();

    test('Verify updating todo item state to completed', () {
      TodoItem item = TodoItem(name: 'test', isCompleted: false);
      viewModel.updateState(item);
      expect(item.isCompleted, true);
    });

    test('Verify updating todo item state to uncompleted', () {
      TodoItem item = TodoItem(name: 'test', isCompleted: true);
      viewModel.updateState(item);
      expect(item.isCompleted, false);
    });
  });
}