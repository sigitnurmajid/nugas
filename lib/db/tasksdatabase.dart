import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:nugas/models/tasks.dart';

class TasksDatabase{
  static final TasksDatabase instance = TasksDatabase._init();

  static Database _database;

  TasksDatabase._init();

  Future<Database> get database async{
    _database = await _initDB('tasks.db');
    return _database;
  }

  Future<Database> _initDB (String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    
    await db.execute('''
    CREATE TABLE $tableTasks (
      ${TasksField.id} $idType,
      ${TasksField.title} $textType,
      ${TasksField.color} $textType,
      ${TasksField.type} $textType,
      ${TasksField.date} $textType
    )
    ''');
  }

  Future<Task> create(Task task) async{
    final db = await instance.database;
    final id = await db.insert(tableTasks, task.toJson());
    return task.copy(id: id);
  }

  Future <List<Task>> readTasks() async{
    final db = await instance.database;
    final result = await db.query(
      tableTasks
    );
    return result.map((json) => Task.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableTasks,
      where: '${TasksField.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}