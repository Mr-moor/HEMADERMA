import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'appointments.db';
  static final _dbVersion = 1;
  static final _tableAvailableDays = 'available_days';
  static final _tableAppointments = 'appointments';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableAvailableDays (
        id INTEGER PRIMARY KEY,
        date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $_tableAppointments (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        date TEXT NOT NULL,
        appointment_date TEXT NOT NULL,
        day_id INTEGER,
        FOREIGN KEY (day_id) REFERENCES $_tableAvailableDays (id)
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getAvailableDays() async {
    Database db = await instance.database;
    return await db.rawQuery('''
      SELECT ad.id, ad.date, COUNT(a.id) as appointments_count
      FROM $_tableAvailableDays ad
      LEFT JOIN $_tableAppointments a ON ad.id = a.day_id
      GROUP BY ad.id
    ''');
  }

  Future<int> getAppointmentCount(int dayId) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('''
      SELECT COUNT(*) FROM $_tableAppointments WHERE day_id = ?
    ''', [dayId])) ?? 0;
  }

  Future<void> bookAppointment(Map<String, dynamic> row) async {
    Database db = await instance.database;
    await db.insert(_tableAppointments, row);
  }

  Future<List<Map<String, dynamic>>> getAppointments() async {
    Database db = await instance.database;
    return await db.query(_tableAppointments);
  }

  Future<int> deleteAvailableDate(int id) async {
  Database db = await instance.database;
  return await db.delete(
    _tableAvailableDays,
    where: 'id = ?',
    whereArgs: [id],
  );

}

Future<int> insertAvailableDate(Map<String, dynamic> row) async {
  Database db = await instance.database;
  return await db.insert(_tableAvailableDays, row);
}

// Function to delete an appointment by ID
  Future<int> deleteAppointment(int id) async {
    Database db = await instance.database;
    return await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
  }

}

