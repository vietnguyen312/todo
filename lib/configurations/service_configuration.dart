import 'package:get_it/get_it.dart';
import 'package:todo/services/todo_repository.dart';

class ServiceConfiguration {
  final _getIt = GetIt.instance;

  ServiceConfiguration._internal();

  static final ServiceConfiguration _instance = ServiceConfiguration._internal();

  static ServiceConfiguration get instance => _instance;

  TodoRepository get todoRepository => _getIt<TodoRepository>();
}