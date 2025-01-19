import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemaderma/view_staff_page.dart';
import 'database_helper.dart' as database;
import 'view_database_page.dart';
class LabTechnicianHomePage extends StatefulWidget {
  final String username;

  LabTechnicianHomePage({required this.username});

  @override
  _LabTechnicianHomePageState createState() => _LabTechnicianHomePageState();
}

class _LabTechnicianHomePageState extends State<LabTechnicianHomePage> {
  late Future<String> _quoteFuture;

  @override
  void initState() {
    super.initState();
    _quoteFuture = _fetchQuote();
  }

  Future<String> _fetchQuote() async {
    await Future.delayed(Duration(seconds: 7));
    return '“Science knows no country, because knowledge belongs to humanity, and is the torch which illuminates the world.”';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab Technician Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_phone),
              title: Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                _showContactDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                _showProfileDialog(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.lightBlue,
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome, ${widget.username}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SharedPatientViewPage(userRole: 'Lab Technician')),
                      );
                    },
                    child: _buildIconColumn(Icons.medical_services, 'Patient Database'),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewStaffPage()),
                      );
                    },
                    child: _buildIconColumn(Icons.group, 'View Staff'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FutureBuilder<String>(
                future: _quoteFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Text(
                        snapshot.data!,
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconColumn(IconData icon, String label) {
    return Column(
      children: <Widget>[
        Icon(icon, size: 50, color: Colors.black),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.black)),
      ],
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About Hemaderma'),
          content: Text(
              'Hemaderma is a platform for managing blood and skin-related diseases.'),
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
    final labProfile =
        await database.DatabaseHelper.instance.getLabtechnicianProfile(widget.username);

    if (labProfile == null) {
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
              Text('Full Name: ${labProfile['full_name']}'),
              Text('Phone Number: ${labProfile['phone_number']}'),
              Text('Email: ${labProfile['email']}'),
              Text('Position: ${labProfile['Position']}'),
              Text('Residence: ${labProfile['residence']}'),
              Text('License Number: ${labProfile['license_number']}'),
              Text('Registration Number: ${labProfile['registration_number']}'),
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
