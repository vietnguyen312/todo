import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/services/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {

  Completer<Database>? _dbOpenCompleter;

  @override
  Future<List<TodoItem>> getTodoItems() async {
    final db = await _database;
    var store = StoreRef.main();
    final snapshots = await store.find(db);
    return snapshots.map((snapshot) {
      return TodoItem.fromJson(snapshot.value, snapshot.key);
    }).toList()
      ..sort((item1, item2) => item2.createdDateInMillis.compareTo(item1.createdDateInMillis));
  }

  @override
  Future updateTodoItem(TodoItem item) async {
    final db = await _database;
    var store = StoreRef.main();
    store.record(item.id).update(db, item.toJson());
  }

  @override
  Future<TodoItem> add(String todo) async {
    final db = await _database;
    final item = TodoItem(name: todo);
    var store = StoreRef.main();
    final id = await store.add(db, item.toJson());
    return item..id = id;
  }

  Future<Database> get _database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'todo.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter!.complete(database);
  }
}