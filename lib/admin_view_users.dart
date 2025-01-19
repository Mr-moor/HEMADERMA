import 'package:flutter/material.dart';
import 'database_helper.dart';

class AdminViewUsersPage extends StatefulWidget {
  @override
  _AdminViewUsersPageState createState() => _AdminViewUsersPageState();
}

class _AdminViewUsersPageState extends State<AdminViewUsersPage> {
  late Future<List<Map<String, dynamic>>> _users;

  @override
  void initState() {
    super.initState();
    _users = DatabaseHelper.instance.queryAllUsers(); // Make sure this method exists
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Users'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No registered users found.'));
          } else {
            final users = snapshot.data!;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user[DatabaseHelper.columnFullName] ?? 'No Name'),
                  subtitle: Text('Username: ${user[DatabaseHelper.columnUsername] ?? 'No Username'}'),
                  trailing: Text(user[DatabaseHelper.columnRole] ?? 'No Role'),
                  onTap: () {
                    // Optional: Show more details or options for the user
                    _showUserDetails(user);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('User Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Full Name: ${user[DatabaseHelper.columnFullName]}'),
              Text('Username: ${user[DatabaseHelper.columnUsername]}'),
              Text('Email: ${user[DatabaseHelper.columnEmail]}'),
              Text('Phone Number: ${user[DatabaseHelper.columnPhoneNumber]}'),
              Text('Gender: ${user[DatabaseHelper.columnGender]}'),
              Text('Residence: ${user[DatabaseHelper.columnResidence]}'),
              Text('Role: ${user[DatabaseHelper.columnRole]}'),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
