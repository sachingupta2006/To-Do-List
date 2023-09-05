// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     } else {
//       _database = await initDatabase();
//       return _database!;
//     }
//   }

//   Future<Database> initDatabase() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, 'your_database_name.db');
//     return await openDatabase(path,
//         version: 1, onCreate: (db, version) async {
//           await db.execute('');
//         });
//   }
  
//   Future<void> insertTask(Task task) async {
//     final db = await database;
//     await db.insert('tasks', task.toMap());
//   }

//   Future<void> updateTask(Task task) async {
//     final db = await database;
//     await db.update('tasks', task.toMap(),
//         where: 'id = ?', whereArgs: [task.id]);
//   }

//   Future<void> deleteTask(int taskId) async {
//     final db = await database;
//     await db.delete('tasks', where: 'id = ?', whereArgs: [taskId]);
//   }

//   Future<List<Task>> getTasks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('tasks');
//     return List.generate(maps.length, (i) {
//       return Task(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//       );
//     });
//   }
// }
// }

