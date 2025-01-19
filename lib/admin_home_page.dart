import 'package:flutter/material.dart';
import 'package:hemaderma/database_helper.dart' as database;
import 'package:hemaderma/admin_view_users.dart';
import 'package:hemaderma/doctor_registration_page.dart';
import 'package:hemaderma/pharcist_registration_page.dart';
import 'package:hemaderma/lab_technician_registration_page.dart';
import 'package:hemaderma/view_database_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminHomePage extends StatelessWidget {
  final String username;
  final dbHelper = database.DatabaseHelper.instance;

  AdminHomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Colors.black),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'View Profile',
                  child: Text('View Profile'),
                ),
                PopupMenuItem<String>(
                  value: 'Contact',
                  child: Text('Contact'),
                ),
                PopupMenuItem<String>(
                  value: 'Log Out',
                  child: Text('Log Out'),
                ),
              ];
            },
            onSelected: (String selectedValue) {
              switch (selectedValue) {
                case 'View Profile':
                Navigator.pop(context);
                  _showProfileDialog(context);
                  break;
                case 'Contact':
                  _showContactDialog(context);
                  break;
                case 'Log Out':
                  Navigator.pushReplacementNamed(context, '/');
                  break;
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Two columns
          crossAxisSpacing: 8.0, // Reduced space between columns
          mainAxisSpacing: 8.0, // Reduced space between rows
          childAspectRatio: 1.2, // Adjusted aspect ratio to make icons closer
          children: [
            _buildIconButton(context, Icons.person_add, 'Register Doctor', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DoctorRegistrationPage()),
              );
            }),
            _buildIconButton(context, Icons.science, 'Register Lab Technician', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LabTechnicianRegistrationPage()),
              );
            }),
            _buildIconButton(context, Icons.local_pharmacy, 'Register Pharmacist', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PharmacistRegistrationPage()),
              );
            }),
            _buildIconButton(context, Icons.people, 'View Registered Users', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminViewUsersPage()),
              );
            }),
            _buildIconButton(context, Icons.medical_services, 'View Patients Records', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SharedPatientViewPage(userRole: 'Admin')),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact Hemaderma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.call),
                title: Text('+254 758 271 319'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('hemaderma@gmail.com'),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.facebook),
                title: Text('Hemaderma'),
              ),
            ],
          ),
          actions: <Widget>[
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


  void _showProfileDialog(BuildContext context) async {
    final AdminProfile = await database.DatabaseHelper.instance.getAdminProfile(username);

    if (AdminProfile == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Profile Error'),
            content: Text('Unable to fetch user profile information.'),
            actions: <Widget>[
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
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('My Profile'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Full Name: ${AdminProfile['fullName']}'),
              Text('Phone Number: ${AdminProfile['phoneNumber']}'),
              Text('Email: ${AdminProfile['email']}'),
              Text('Position: ${AdminProfile['position']}'),
              Text('Role: ${AdminProfile['Role']}'),
            ],
          ),
          actions: <Widget>[
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
