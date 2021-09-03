import 'package:uuid/uuid.dart';

class TodoItem {
  String uuid = Uuid().v1();
  late String name;
  bool isCompleted = false;

  TodoItem({required this.name, this.isCompleted = false});
}
