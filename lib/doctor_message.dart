import 'package:flutter/material.dart';
import 'user_message.dart'; // Ensure this file exists and is properly structured
import 'database_helper.dart' as database;

class DoctorMessageScreen extends StatefulWidget {
  final int doctorId; // Pass the doctor ID to the screen

  DoctorMessageScreen({required this.doctorId});

  @override
  _DoctorMessageScreenState createState() => _DoctorMessageScreenState();
}

class _DoctorMessageScreenState extends State<DoctorMessageScreen> {
  final database.DatabaseHelper _dbHelper = database.DatabaseHelper.instance; // Singleton instance of the database helper
  List<Map<String, dynamic>> users = []; // Holds the list of unique users

  @override
  void initState() {
    super.initState();
    _loadUsersAndMessages();
  }

  // Fetches unique users associated with the doctor
  Future<void> _loadUsersAndMessages() async {
    try {
      // Fetch unique users for this specific doctor
      users = await _dbHelper.getUniqueUsers(widget.doctorId);
      setState(() {}); // Refresh the UI after fetching users
    } catch (e) {
      print("Error loading users and messages: $e");
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Doctor Messages'),
      backgroundColor: Colors.lightBlueAccent,
    ),
    body: users.isNotEmpty
        ? ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              String username = users[index]['username'];
              int userId = users[index]['Id'];

              return ListTile(
                title: Text(username),
                onTap: () {
                  // Navigate to the UserMessageScreen for the selected user
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserMessageScreen(
                        id: userId, // Pass the userId to the UserMessageScreen
                        doctorId: widget.doctorId, // Pass the doctorId to UserMessageScreen
                      ),
                    ),
                  ).then((_) {
                    // Refresh the list of users/messages when returning
                    _loadUsersAndMessages();
                  });
                },
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(), // Show loading indicator while fetching users
          ),
  );
}
}