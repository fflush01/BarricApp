import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:barricapp/features/cava/models/wine.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cava_database.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE vinos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            tipo_uva TEXT NOT NULL,
            anada TEXT NOT NULL,
            calificacion REAL NOT NULL,
            notas_degustacion TEXT,
            maridaje TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertWine(Wine wine) async {
    final db = await database;
    return await db.insert(
      'vinos',
      wine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Wine>> getWines() async {
    final db = await database;
    
    final List<Map<String, dynamic>> maps = await db.query('vinos');
    
    return List.generate(maps.length, (i) {
      return Wine.fromMap(maps[i]);
    });
  }

  Future<int> deleteWine(int id) async {
    final db = await database;
    return await db.delete(
      'vinos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateWine(Wine wine) async {
    final db = await database;
    return await db.update(
      'vinos',
      wine.toMap(),
      where: 'id = ?',
      whereArgs: [wine.id],
    );
  }
}