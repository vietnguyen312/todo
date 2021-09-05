import 'package:json_annotation/json_annotation.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class TodoItem {
  @JsonKey(ignore: true)
  int? id;

  int createdDateInMillis = DateTime.now().millisecondsSinceEpoch;
  late String name;
  bool isCompleted = false;

  TodoItem({required this.name, this.isCompleted = false});

  factory TodoItem.fromJson(Map<String, dynamic> json, int id) => _$TodoItemFromJson(json)..id = id;

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
