import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'health_records.db';
  static final _dbVersion = 1;
  static final _tablePHR = 'personal_health_records';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE $_tablePHR (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        ambulatory_visits TEXT,
        hospitalizations TEXT,
        allergies TEXT,
        family_history TEXT,
        immunization_records TEXT,
        conditions TEXT,
        medications TEXT,
        surgeries TEXT
      )
    ''');
  }

  // Insert PHR Data
  Future<void> insertPHR(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(_tablePHR, row);
  }

  // Fetch PHR Data for a specific user
  Future<Map<String, dynamic>?> getPHR(String username) async {
    Database db = await instance.database;
    final result = await db.query(
      _tablePHR,
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  Future<int> updatePHR(String username, Map<String, dynamic> updatedPHR) async {
  final db = await database;
  return await db.update(
    _tablePHR, // Assuming your table name is 'phr'
    updatedPHR,
    where: 'username = ?',
    whereArgs: [username],
  );
}

// Method to get all PHR records
  Future<List<Map<String, dynamic>>> getAllPHR() async {
    Database db = await instance.database;
    return await db.query(_tablePHR);
  }

}
