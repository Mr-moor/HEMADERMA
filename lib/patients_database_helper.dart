import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PatientDatabaseHelper {
  static final _dbName = 'patients_database.db';  // Separate DB for patients
  static final _dbVersion = 1;
  static final _tableName = 'patients';  // Table for patients

  PatientDatabaseHelper._privateConstructor();
  static final PatientDatabaseHelper instance = PatientDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize and create the database if it doesn't exist
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  // Create the patients table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        full_name TEXT,
        age INTEGER,
        gender TEXT,
        phone_number TEXT,
        residence TEXT,
        lab_test TEXT,
        lab_result TEXT,
        illness TEXT,
        referred TEXT,
        referred_hospital TEXT,
        drug_prescribed TEXT,
        time TEXT
      )
    ''');
  }

  // Insert patient data
  Future<int> insertPatient(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  // Get all patients
  Future<List<Map<String, dynamic>>> getAllPatients() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  // Get a single patient by ID
  Future<Map<String, dynamic>?> getPatientById(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  // Update a patient record
  Future<int> updatePatient(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(_tableName, row, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a patient record
  Future<int> deletePatient(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
