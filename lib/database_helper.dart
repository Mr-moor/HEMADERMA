import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _userDatabaseName = "Hemaderma.db";
  static const _adminDatabaseName = "Admin.db";
  static const _doctorDatabaseName = "Doctors.db";
  static const _labtechnicianDatabaseName = "Lab.db";
  static const _pharmacistDatabaseName = 'Pharmacist.db';
  static const labtechnicianTable = 'lab_technicians';
  static const _appointmentDatabaseName = 'Appointments.db';
  static const _sessionsDatabaseName = 'sessions.db';
  static const _messageDatabaseName = 'messages.db';

  
  // Doctor table
  static const doctorTable = 'doctor';
  static const columnRegistrationNumber = 'registration_number';
  static const columnLicenseNumber = 'license_number';
  static const columnStatus = 'status';

//pharmacist tabele
  static const pharmacistTable = 'pharmacists';
  static const _databaseVersion = 1;

  // sessions table 
  static const sessionsTable = 'sessions';
  static const columnuser_id = 'user_id';
  static const columnis_logged_in = 'is_logged_in';

//messages table
  static const messageTable = 'messages';
  static const  columnDoctorId= 'DoctorId';
  static const columnUserId = 'UserId';
  static const columnMessage = 'message';
  static const columnTimestamp = 'TimeStamp';


  // User table
  static const userTable = 'users';
  static const columnId = '_id';
  static const columnFullName = 'full_name';
  static const columnPhoneNumber = 'phone_number';
  static const columnEmail = 'email';
  static const columnGender = 'gender';
  static const columnResidence = 'residence';
  static const columnAge = 'age';
  static const columnSecurityQuestion = 'security_question';
  static const columnSecurityAnswer = 'security_answer';
  static const columnUsername = 'username';
  static const columnPassword = 'password';
  // Admin table
  static const adminTable = 'Admin';
  static const columnRole = 'role';
  static const columnAddress = 'address';
  static const columnPosition = 'position';
  static const columnEmergencyContact = 'emergency_contact';
  static const columnIsTwoFactorEnabled = 'is_two_factor_enabled';

  static const appointmentTable = 'appointments';
   static const columnDoctorUsername = 'doctor_username';
  static const columnPatientUsername = 'patient_username';
  static const columnAppointmentDate = 'appointment_date';
  static const columnAppointmentTime = 'appointment_time';


  // Singleton instance
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
   
static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal(); // Private constructor

  factory DatabaseHelper() {
    return _instance; // Return the singleton instance
  }


  static Database? _userDatabase;
  static Database? _adminDatabase;
  static Database? _doctorDatabase;
  static Database? _labtechnicianDatabase;
  static Database? _pharmacistDatabase;
 static Database? _appointmentDatabase;
static Database? _sessionsDatabase;
static Database? _messageDatabase;


// Function to hash the password using SHA-256
String hashPassword(String password) {
  return sha256.convert(utf8.encode(password)).toString();
}

  Future<Database?> get userDatabase async {
    if (_userDatabase != null) return _userDatabase;

    // Instantiate the user database only when it's accessed the first time.
    _userDatabase = await _initDatabase(_userDatabaseName);
    return _userDatabase;
  }

  Future<Database?> get adminDatabase async {
    if (_adminDatabase != null) return _adminDatabase;

    // Instantiate the admin database only when it's accessed the first time.
    _adminDatabase = await _initDatabase(_adminDatabaseName);
    print('Admin Database Initialized');
    return _adminDatabase;
  }

  Future<Database?> get doctorDatabase async {
    if (_doctorDatabase != null) return _doctorDatabase;

    // Instantiate the admin database only when it's accessed the first time.
    _doctorDatabase = await _initDatabase(_doctorDatabaseName);
    print('doctor Database Initialized');
    return _doctorDatabase;
  }

  Future<Database?> get labtechnicianDatabase async {
    if (_labtechnicianDatabase != null) return _labtechnicianDatabase;

    // Instantiate the admin database only when it's accessed the first time.
    _labtechnicianDatabase = await _initDatabase(_labtechnicianDatabaseName);
    print('lab technician Database Initialized');
    return _labtechnicianDatabase;
  }

  Future<Database?> get pharmacistDatabase async {
    if (_pharmacistDatabase != null) return _pharmacistDatabase;

    // Instantiate the admin database only when it's accessed the first time.
    _pharmacistDatabase = await _initDatabase(_pharmacistDatabaseName);
    print('pharmacist Database Initialized');
    return _pharmacistDatabase;
  }

// Getter for appointment database
  Future<Database?> get appointmentDatabase async {
    if (_appointmentDatabase != null) return _appointmentDatabase;
    _appointmentDatabase = await _initDatabase(_appointmentDatabaseName);
    return _appointmentDatabase;
  }

 Future<Database?> get sessionsDatabase async {
    if (_sessionsDatabase != null) return _sessionsDatabase;

    // Instantiate the user database only when it's accessed the first time.
    _sessionsDatabase = await _initDatabase(_sessionsDatabaseName);
    return _sessionsDatabase;
  }

  Future<Database?> get messageDatabase async {
    if (_messageDatabase != null) return _messageDatabase;

    // Instantiate the user database only when it's accessed the first time.
    _messageDatabase = await _initDatabase(_messageDatabaseName);
    return _messageDatabase;
  }

  Future<Database?> _initDatabase(String dbName) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);
    print('Database path: $path');
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase(_messageDatabaseName);
    return _database!;
  }


  Future _onCreate(Database db, int version) async {
    if (db.path.endsWith(_userDatabaseName)) {
      await db.execute('''
            CREATE TABLE $userTable (
              $columnId INTEGER PRIMARY KEY,
              $columnFullName TEXT NOT NULL,
              $columnPhoneNumber TEXT NOT NULL,
              $columnEmail TEXT NOT NULL,
              $columnGender TEXT NOT NULL,
              $columnResidence TEXT NOT NULL,
              $columnAge TEXT NOT NULL,
              $columnSecurityQuestion TEXT NOT NULL,
              $columnSecurityAnswer TEXT NOT NULL,
              $columnUsername TEXT NOT NULL,
              $columnPassword TEXT NOT NULL,
              $columnRole TEXT NOT NULL
            )
            ''');
    } else if (db.path.endsWith(_adminDatabaseName)) {
      await db.execute('''
            CREATE TABLE $adminTable (
              $columnId INTEGER PRIMARY KEY,
              $columnFullName TEXT NOT NULL,
              $columnEmail TEXT NOT NULL,
              $columnPhoneNumber TEXT NOT NULL,
              $columnUsername TEXT NOT NULL,
              $columnPassword TEXT NOT NULL,
              $columnAddress TEXT NOT NULL,
              $columnPosition TEXT NOT NULL,
              $columnEmergencyContact TEXT NOT NULL,
              $columnSecurityQuestion TEXT NOT NULL,
              $columnSecurityAnswer TEXT NOT NULL,
              $columnRole TEXT NOT NULL,
              $columnIsTwoFactorEnabled INTEGER NOT NULL
            )
            ''');
    } else if (db.path.endsWith(_doctorDatabaseName)) {
      await db.execute('''
          CREATE TABLE $doctorTable (
            $columnId INTEGER PRIMARY KEY,
            $columnFullName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnPhoneNumber TEXT NOT NULL,
            $columnAddress TEXT NOT NULL,
            $columnPosition TEXT NOT NULL,
            $columnSecurityQuestion TEXT NOT NULL,
            $columnSecurityAnswer TEXT NOT NULL,
            $columnEmergencyContact TEXT NOT NULL,
            $columnRole TEXT NOT NULL,
            $columnUsername TEXT NOT NULL,
            $columnPassword TEXT NOT NULL,
            $columnRegistrationNumber TEXT NOT NULL,
            $columnLicenseNumber TEXT NOT NULL,
            $columnStatus TEXT NOT NULL,
            $columnIsTwoFactorEnabled INTEGER NOT NULL
          )
          ''');
    } else if (db.path.endsWith(_labtechnicianDatabaseName)) {
      await db.execute('''
CREATE TABLE $labtechnicianTable(
            $columnId INTEGER PRIMARY KEY,
            $columnFullName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnPhoneNumber TEXT NOT NULL,
            $columnAddress TEXT NOT NULL,
            $columnPosition TEXT NOT NULL,
            $columnSecurityQuestion TEXT NOT NULL,
            $columnSecurityAnswer TEXT NOT NULL,
            $columnEmergencyContact TEXT NOT NULL,
            $columnRole TEXT NOT NULL,
            $columnUsername TEXT NOT NULL,
            $columnPassword TEXT NOT NULL,
            $columnRegistrationNumber TEXT NOT NULL,
            $columnLicenseNumber TEXT NOT NULL,
            $columnStatus TEXT NOT NULL,
            $columnIsTwoFactorEnabled INTEGER NOT NULL
         )
         ''');
    } else if (db.path.endsWith(_pharmacistDatabaseName)) {
      await db.execute('''
          CREATE TABLE $pharmacistTable (
            $columnId INTEGER PRIMARY KEY,
            $columnFullName TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnPhoneNumber TEXT NOT NULL,
            $columnAddress TEXT NOT NULL,
            $columnPosition TEXT NOT NULL,
            $columnSecurityQuestion TEXT NOT NULL,
            $columnSecurityAnswer TEXT NOT NULL,
            $columnEmergencyContact TEXT NOT NULL,
            $columnRole TEXT NOT NULL,
            $columnUsername TEXT NOT NULL,
            $columnPassword TEXT NOT NULL,
            $columnRegistrationNumber TEXT NOT NULL,
            $columnLicenseNumber TEXT NOT NULL,
            $columnStatus TEXT NOT NULL,
            $columnIsTwoFactorEnabled INTEGER NOT NULL
          )
          ''');
    }
    else if (db.path.endsWith(_appointmentDatabaseName)) {
      await db.execute('''
            CREATE TABLE $appointmentTable (
              $columnId INTEGER PRIMARY KEY,
              $columnDoctorUsername TEXT NOT NULL,
              $columnPatientUsername TEXT NOT NULL,
              $columnAppointmentDate TEXT NOT NULL,
              $columnAppointmentTime TEXT NOT NULL
            )
            ''');
    } else if (db.path.endsWith(_sessionsDatabaseName)) {
     await db.execute('''
    CREATE TABLE $sessionsTable (
      $columnId INTEGER PRIMARY KEY,
      $columnuser_id INTEGER,
      $columnis_logged_in INTEGER
    )
  ''');
    } else if (db.path.endsWith(_messageDatabaseName)){
      await db.execute('''
      CREATE TABLE $messageTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUsername TEXT NOT NULL,
        $columnMessage TEXT NOT NULL,
        $columnTimestamp TEXT NOT NULL
      )
    ''');

    }
    
     // Method to check if a table exists
  Future<bool> tableExists(String sessionsTable) async {
    Database? db = await instance.sessionsDatabase;
    try {
      var result = await db?.rawQuery(
          "SELECT Username FROM sqlite_master WHERE type='table' AND name=?", [sessionsTable]);
      return result != null && result.isNotEmpty;
    } catch (e) {
      print("Error checking if table exists: $e");
      return false;
    }
  }
      print("Admin,doctor,labtechnician,pharmacist and appointment database created at ${db.path}");
    
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await sessionsDatabase;
    return await db!
        .insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Insert user
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database? db = await instance.userDatabase;
    return await db!.insert(userTable, row);
  }

  // Insert admin
  Future<int> insertAdmin(Map<String, dynamic> row) async {
    Database? db = await instance.adminDatabase;
    return await db!.insert(adminTable, row);
  }

  Future<int> insertDoctor(Map<String, dynamic> row) async {
    Database? db = await instance.doctorDatabase;
    return await db!.insert(doctorTable, row);
  }

  Future<int> insertLabtechnician(Map<String, dynamic> row) async {
    Database? db = await instance.labtechnicianDatabase;
    return await db!.insert(labtechnicianTable, row);
  }

  Future<int> insertpharmacist(Map<String, dynamic> row) async {
    Database? db = await instance.pharmacistDatabase;
    return await db!.insert(pharmacistTable, row);
  }


  Future<int> insertAppointment(Map<String, dynamic> row) async {
    Database? db = await instance.appointmentDatabase;
    return await db!.insert(appointmentTable, row);
  }

Future<int> insertSessions(Map<String, dynamic> row) async {
    Database? db = await instance.sessionsDatabase;
    return await db!.insert(sessionsTable, row);
  }

  Future<int> insertmessage(Map<String, dynamic> row) async {
    Database? db = await instance.messageDatabase;
    return await db!.insert(messageTable, row);
  }
  // Query for appointments and patients
  Future<List<Map<String, dynamic>>> queryAppointmentsForDoctor(String doctorUsername) async {
    Database? db = await instance.appointmentDatabase;
    return await db!.query(appointmentTable,
        where: '$columnDoctorUsername = ?', whereArgs: [doctorUsername]);
  }

  // Query user
  Future<Map<String, dynamic>?> queryUser(String username) async {
    Database? db = await instance.userDatabase;
    List<Map<String, dynamic>> maps = await db!.query(userTable,
        columns: [
          columnId,
          columnFullName,
          columnPhoneNumber,
          columnEmail,
          columnGender,
          columnResidence,
          columnAge,
          columnSecurityQuestion,
          columnSecurityAnswer,
          columnUsername,
          columnPassword,
          columnRole,
        ],
        where: '$columnUsername = ?',
        whereArgs: [username]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Get user profile
  Future<Map<String, dynamic>?> getUserProfile(String username) async {
    Database? db = await instance.userDatabase;
    List<Map<String, dynamic>> maps = await db!.query(
      userTable,
      columns: [
        columnFullName,
        columnPhoneNumber,
        columnEmail,
        columnGender,
        columnResidence,
        columnAge,
      ],
      where: '$columnUsername = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Update user password
  Future<int> updatePassword(String username, String password) async {
    Database? db = await instance.userDatabase;
    return await db!.update(userTable, {columnPassword: password},
        where: '$columnUsername = ?', whereArgs: [username]);
  }

  // Query admin
  Future<Map<String, dynamic>?> queryAdmin(
      String username, String password) async {
    Database? db = await instance.adminDatabase;
    List<Map<String, dynamic>> maps = await db!.query(adminTable,
        columns: [
          columnId,
          columnFullName,
          columnEmail,
          columnPhoneNumber,
          columnUsername,
          columnPassword,
          columnAddress,
          columnPosition,
          columnEmergencyContact,
          columnSecurityQuestion,
          columnSecurityAnswer,
          columnRole,
          columnIsTwoFactorEnabled
        ],
        where: '$columnUsername = ? AND $columnPassword = ?',
        whereArgs: [username, hashPassword(password)]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

 Future<Map<String, dynamic>?> getAdminProfile(String username) async {
    Database? db = await instance.adminDatabase;
    List<Map<String, dynamic>> maps = await db!.query(
      userTable,
      columns: [
        columnFullName,
        columnPhoneNumber,
        columnEmail,
        columnPosition,
        columnRole,
      
      ],
      where: '$columnUsername = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> queryDoctor(
      String username,String password) async {
    Database? db = await instance.doctorDatabase;
    List<Map<String, dynamic>> maps = await db!.query(doctorTable,
        columns: [
          columnId,
          columnFullName,
          columnEmail,
          columnPhoneNumber,
          columnAddress,
          columnPosition,
          columnSecurityQuestion,
          columnSecurityAnswer,
          columnEmergencyContact,
          columnRole,
          columnUsername,
          columnPassword,
          columnRegistrationNumber,
          columnLicenseNumber,
          columnStatus,
          columnIsTwoFactorEnabled
        ],
        where: '$columnUsername = ? AND $columnPassword = ?',
        whereArgs: [username, hashPassword(password)]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getDoctorProfile(String username) async {
    Database? db = await instance.doctorDatabase;
    List<Map<String, dynamic>> maps = await db!.query(
      doctorTable,
      columns: [
        columnFullName,
        columnPhoneNumber,
        columnEmail,
        columnPosition,
        columnResidence,
        columnLicenseNumber,
        columnRegistrationNumber,
      ],
      where: '$columnUsername = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> queryLabtechnician(
      String username, String password) async {
    Database? db = await instance.labtechnicianDatabase;
    List<Map<String, dynamic>> maps = await db!.query(labtechnicianTable,
        columns: [
          columnId,
          columnFullName,
          columnEmail,
          columnPhoneNumber,
          columnAddress,
          columnPosition,
          columnSecurityQuestion,
          columnSecurityAnswer,
          columnEmergencyContact,
          columnRole,
          columnUsername,
          columnPassword,
          columnRegistrationNumber,
          columnLicenseNumber,
          columnStatus,
          columnIsTwoFactorEnabled
        ],
        where: '$columnUsername = ? AND $columnPassword = ?',
        whereArgs: [username, hashPassword(password)]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getLabtechnicianProfile(String username) async {
    Database? db = await instance.labtechnicianDatabase;
    List<Map<String, dynamic>> maps = await db!.query(
       labtechnicianTable,
      columns: [
        columnFullName,
        columnPhoneNumber,
        columnEmail,
        columnPosition,
        columnResidence,
        columnLicenseNumber,
        columnRegistrationNumber,
      ],
      where: '$columnUsername = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> querypharmacist(
      String username, String password) async {
    Database? db = await instance.pharmacistDatabase;
    List<Map<String, dynamic>> maps = await db!.query(pharmacistTable,
        columns: [
          columnId,
          columnFullName,
          columnEmail,
          columnPhoneNumber,
          columnAddress,
          columnPosition,
          columnSecurityQuestion,
          columnSecurityAnswer,
          columnEmergencyContact,
          columnRole,
          columnUsername,
          columnPassword,
          columnRegistrationNumber,
          columnLicenseNumber,
          columnStatus,
          columnIsTwoFactorEnabled
        ],
        where: '$columnUsername = ? AND $columnPassword = ?',
        whereArgs: [username, hashPassword(password)]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getpharmacistProfile(String username) async {
    Database? db = await instance.pharmacistDatabase;
    List<Map<String, dynamic>> maps = await db!.query(
      pharmacistTable,
      columns: [
        columnFullName,
        columnPhoneNumber,
        columnEmail,
        columnPosition,
        columnResidence,
        columnLicenseNumber,
        columnRegistrationNumber,
      ],
      where: '$columnUsername = ?',
      whereArgs: [username],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Method to update user password
  Future<int> updateUserPassword(String username, String password) async {
    Database? db = await instance.userDatabase;
    return await db!.update(userTable, {columnPassword: password},
        where: '$columnUsername = ?', whereArgs: [username]);
  }

  // Method to update doctor password
  Future<int> updateDoctorPassword(String username, String password) async {
    Database? db = await instance.doctorDatabase;
    return await db!.update(doctorTable, {columnPassword: password},
        where: '$columnUsername = ?', whereArgs: [username]);
  }

  // Method to update admin password
  Future<int> updateAdminPassword(String username, String password) async {
    Database? db = await instance.adminDatabase;
    return await db!.update(adminTable, {columnPassword: password},
        where: '$columnUsername = ?', whereArgs: [username]);
  }

  // Method to update pharmacist password
  Future<int> updatePharmacistPassword(
      String username, String password) async {
    Database? db = await instance.pharmacistDatabase;
    return await db!.update(pharmacistTable, {columnPassword: password},
        where: '$columnUsername = ?', whereArgs: [username]);
  }

  // Method to update lab technician password
  Future<int> updateLabTechnicianPassword(
      String username, String password) async {
    Database? db = await instance.labtechnicianDatabase;
    return await db!.update(labtechnicianTable, {columnPassword: password},
        where: '$columnUsername = ?', whereArgs: [username]);
  }
  // Method to fetch all Admins
Future<List<Map<String, dynamic>>> getAllAdmins() async {
  Database? db = await instance.adminDatabase;
  return await db!.query(
    adminTable,
    columns: [columnFullName, columnPhoneNumber, columnEmail, columnAddress],
  );
}

// Method to fetch all Doctors
Future<List<Map<String, dynamic>>> getAllDoctors() async {
  Database? db = await instance.doctorDatabase;
  return await db!.query(
    doctorTable,
    columns: [columnFullName, columnPhoneNumber, columnEmail, columnAddress],
  );
}

// Method to fetch all Lab Technicians
Future<List<Map<String, dynamic>>> getAllLabTechnicians() async {
  Database? db = await instance.labtechnicianDatabase;
  return await db!.query(
    labtechnicianTable,
    columns: [columnFullName, columnPhoneNumber, columnEmail, columnAddress],
  );
}

// Method to fetch all Pharmacists
Future<List<Map<String, dynamic>>> getAllPharmacists() async {
  Database? db = await instance.pharmacistDatabase;
  return await db!.query(
    pharmacistTable,
    columns: [columnFullName, columnPhoneNumber, columnEmail, columnAddress],
  );
}
// Query all Admins
Future<List<Map<String, dynamic>>> queryAllAdmin() async {
  Database? db = await instance.adminDatabase;
  return await db!.query(adminTable, columns: [
    columnFullName,
    columnPhoneNumber,
    columnEmail,
    columnAddress,
    columnRole
  ]);
}

// Query all Doctors
Future<List<Map<String, dynamic>>> queryAllDoctors() async {
  Database? db = await instance.doctorDatabase;
  return await db!.query(doctorTable, columns: [
    columnFullName,
    columnPhoneNumber,
    columnEmail,
    columnAddress,
    columnRole
  ]);
}

//quer all users
// In database_helper.dart
Future<List<Map<String, dynamic>>> queryAllUsers() async {
  final db = await instance.userDatabase;
  return await db!.query(userTable, columns: [
    columnFullName,
    columnUsername,
    columnEmail,
    columnPhoneNumber,
    columnGender,
    columnResidence,
    columnRole,

  ]);
}


// Query all Lab Technicians
Future<List<Map<String, dynamic>>> queryAllLabTechnicians() async {
  Database? db = await instance.labtechnicianDatabase;
  return await db!.query(labtechnicianTable, columns: [
    columnFullName,
    columnPhoneNumber,
    columnEmail,
    columnAddress,
    columnRole
  ]);
}

// Query all Pharmacists
Future<List<Map<String, dynamic>>> queryAllPharmacists() async {
  Database? db = await instance.pharmacistDatabase;
  return await db!.query(pharmacistTable, columns: [
    columnFullName,
    columnPhoneNumber,
    columnEmail,
    columnAddress,
    columnRole
  ]);
}

  // Function to get the doctor's username using their id
  Future<String?> getDoctorUsername(int doctorId) async {
    Database? db = await instance.doctorDatabase;

    final List<Map<String, dynamic>> result = await db!.query(
      doctorTable,
      columns: ['username'], // Fetch only the username
      where: 'id = ?',
      whereArgs: [doctorId],
    );

    if (result.isNotEmpty) {
      return result.first['username'] as String?;
    } else {
      return null; // Return null if no doctor found with the given ID
    }
  }


  // Method to get a user's username by their ID
  Future<String?> getUserUsername(int userId) async {
    final db = await instance.userDatabase;
    var result = await db!.query(
      userTable, // Replace with your users table name
      columns: ['Username'], // Column you want to retrieve
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result.first['Username'] as String;
    } else {
      return null; // or handle the case when no username is found
    }
  }

   // Get current user ID function
  Future<int?> getCurrentUserId(int userId) async {
    final db = await instance.sessionsDatabase;

    final List<Map<String, dynamic>> userSessions = await db!.query(
      sessionsTable, // Replace with  actual sessions table name
      where: 'is_logged_in = ?',
      whereArgs: [1], // Assuming a column 'is_logged_in' indicates if the user is logged in
      limit: 0,
    );

    if (userSessions.isNotEmpty) {
      return userSessions.first['user_id']; 
    }
    return null; // Return null if no logged-in user is found
  }

  Future<List<Map<String, dynamic>>> getMessagesForUser(int userId) async {
    final db = await instance.sessionsDatabase; // Get the database instance
    return await db!.query('messages', where: 'user_id = ?', whereArgs: [userId]); // Adjust according to your database schema
  }

  // Insert a message into the messages table
  Future<int> insertMessage(String username, String message, String timestamp) async {
    final db = await instance.database;
    return await db.insert(
      messageTable,
      {
        columnUsername: username,
        columnMessage: message,
        columnTimestamp: timestamp,
      },
    );
  }

  // Fetch unique users for a specific doctor
  Future<List<Map<String, dynamic>>> getUniqueUsers(int doctorId) async {
    final db = await instance.messageDatabase;

    // Query the messages table to find unique user IDs for a specific doctor
    final List<Map<String, dynamic>> result = await db!.rawQuery('''
      SELECT DISTINCT userId, username FROM $messageTable WHERE doctorId = ?
    ''', [doctorId]);

    return result;
  }

  // Fetch doctorId based on the doctor's username
  Future<int?> getDoctorId(String username) async {
    final db = await instance.doctorDatabase;

    // Query the doctors table to find the doctorId by username
    List<Map<String, dynamic>> result = await db!.query(
      doctorTable, // Replace with your actual doctors table name
      columns: ['id'], // Assuming the id column holds the doctorId
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int;
    }
    return null; // Return null if no doctor was found
  }

  Future<int?> verifyLogin(String username, String password) async {
  final db = await userDatabase; // Access user database

  if (db == null) {
    print('Error: User database is not initialized.');
    return null;
  }

  // Hash the provided password using SHA-256
  var hashedPassword = hashPassword(password);

  // Query the user database to find the user
  List<Map<String, dynamic>> result = await db.query(
    userTable,
    columns: [columnId, columnUsername, columnPassword],
    where: '$columnUsername = ? AND $columnPassword = ?',
    whereArgs: [username, hashedPassword],
  );

  // If a user is found, return the user ID
  if (result.isNotEmpty) {
    return result.first[columnId] as int;
  } else {
    // Return null if no user is found
    print('Login failed: Invalid username or password.');
    return null;
  }
}


}
