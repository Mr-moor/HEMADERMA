import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class Message {
  int? id;
  int senderId;
  int receiverId;
  String message;
  String timestamp;

  Message({
    this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  // Convert Message object to Map for inserting into SQLite
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  // Convert Map from SQLite into a Message object
  static Message fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      message: map['message'],
      timestamp: map['timestamp'],
    );
  }
}


class DatabaseHelper {
  static final _databaseName = "chat_database.db"; // Database name
  static final _databaseVersion = 1;

  static final table = 'messages'; // Messages table

  static final columnId = 'id';
  static final columnSenderId = 'senderId'; // ID of the sender (user or doctor)
  static final columnReceiverId = 'receiverId'; // ID of the receiver (user or doctor)
  static final columnContent = 'message'; // Message content
  static final columnTimestamp = 'timestamp'; // Message timestamp

  // Make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Create the messages table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnSenderId INTEGER NOT NULL,
            $columnReceiverId INTEGER NOT NULL,
            $columnContent TEXT NOT NULL,
            $columnTimestamp TEXT NOT NULL
          )
          ''');
  }

  // Insert a new message into the messages table
  Future<int> insertMessage(int senderId, int receiverId, String message) async {
  Database db = await instance.database;
  Map<String, dynamic> row = {
    columnSenderId: senderId,
    columnReceiverId: receiverId,
    columnContent: message, // Use 'message' here
    columnTimestamp: DateTime.now().toIso8601String()
  };
  return await db.insert(table, row);
}


  // Get all messages between the user and the doctor
  Future<List<Map<String, dynamic>>> getMessages(int userId, int doctorId) async {
    Database db = await instance.database;
    
    return await db.query(table,
        where: "($columnSenderId = ? AND $columnReceiverId = ?) OR ($columnSenderId = ? AND $columnReceiverId = ?)",
        whereArgs: [userId, doctorId, doctorId, userId],
        orderBy: '$columnTimestamp DESC'); // Latest messages come first
  }

  // Fetch unique users that have communicated with a specific doctor
Future<List<Map<String, dynamic>>> getUniqueUsers(int doctorId) async {
  Database db = await instance.database;

  return await db.rawQuery('''
    SELECT DISTINCT u.username, u.Id
    FROM messages m
    JOIN users u ON (m.senderId = u.Id OR m.receiverId = u.Id)
    WHERE (m.senderId = ? OR m.receiverId = ?)
  ''', [doctorId, doctorId]);
}
}

