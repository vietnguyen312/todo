import 'package:flutter/widgets.dart';
import 'package:todo/configurations/service_configuration.dart';
import 'package:todo/services/todo_repository.dart';

class TodoHomePageViewModel with ChangeNotifier {
  TodoRepository repository = ServiceConfiguration.instance.todoRepository;

  TodoHomePageViewModel();
}
