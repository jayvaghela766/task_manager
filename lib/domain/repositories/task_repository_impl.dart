import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../data/models/task.dart';
import '../../data/repositories/task_repository.dart';
import 'package:path/path.dart';


/// Concrete implementation of the TaskRepository interface using SQLite database.
class TaskRepositoryImpl extends TaskRepository {
  static Database? _database;

  set setDatabase(Database value) {
    _database = value;
  }

  /// Getter for the database instance.
  Future<Database> get database async {
    // sqfliteFfiInit();
    // databaseFactory = databaseFactoryFfi;
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  /// Initialize the database.
  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)",
        );
      },
    );
  }

  /// Adds a task to the database.
  @override
  Future<void> addTask(Task task) async {
    final db = await database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieves all tasks from the database.
  @override
  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  /// delete tasks from the database.
  @override
  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
