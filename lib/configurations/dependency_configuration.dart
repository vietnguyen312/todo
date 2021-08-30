import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/configurations/dependency_configuration.config.dart';
import 'package:todo/services/todo_repository.dart';
import 'package:todo/services/todo_repository_impl.dart';

@injectableInit
void configureDependencies() => $initGetIt(GetIt.instance);

@module
abstract class RegisterDependencies {

  @LazySingleton(as: TodoRepository)
  TodoRepositoryImpl get todoRepository;
}
