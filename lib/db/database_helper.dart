import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/record.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'household_book.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE records(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount INTEGER NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<Record> insertRecord(Record record) async {
    final db = await database;
    record.id = await db.insert('records', record.toMap());
    return record;
  }

  Future<List<Record>> getRecords() async {
    final db = await database;
    final result = await db.query('records', orderBy: 'date DESC');
    return result.map((json) => Record.fromMap(json)).toList();
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
