import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemaderma/appointments.dart';
import 'package:hemaderma/video_call_page.dart';
import 'package:hemaderma/database_helper.dart' as database;
import 'user_message.dart';
import 'health_blog_page.dart';
import 'appointments.dart';
import 'phr_entry_page.dart';
import 'message_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'medicine_reminder_page.dart';
import 'doctor_appointments_reminder.dart';


class UserHomePage extends StatefulWidget {
  final String username;
  final String doctorUsername = '';

  UserHomePage({required this.username});
  final dbHelper = database.DatabaseHelper.instance;

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late Future<String> _quoteFuture;
  bool _showDoctorSubIcons = false; // Track whether to show the sub-icons
  final database.DatabaseHelper _databaseHelper = database.DatabaseHelper.instance;

int userId=0;
int? id; //login verification method
  @override
  void initState() {
    super.initState();
    _fetchUserId();
    _quoteFuture = _fetchQuote(); // Initialize the fetch quote method
  }

  Future<void> _fetchUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? storedUserId = prefs.getInt('user_id');
  
}

  Future<String> _fetchQuote() async {
    await Future.delayed(Duration(seconds: 7));
    return '“Take care of your body its the only place you have to live.” – Jim Rohn';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Home Page'),
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
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog(context);
              },
            ),
            ListTile( 
              title: Text('Contact'),
              onTap: () {
                Navigator.pop(context);
                _showContactDialog(context);
              },
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () {
                Navigator.pop(context);
                _showProfileDialog(context);
              },
            ),
            ListTile(
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
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PHREntryPage(username: '')),
                      );
                    },
                    child: _buildIconColumn(Icons.health_and_safety, 'PHR'),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewHealthBlogPage()),
                      );
                    },
                    child: _buildIconColumn(Icons.article, 'Health Blogs'),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicineReminderPage()),
                      );
                    },
                    child: _buildIconColumn(Icons.medical_services, 'Medicine Reminder'),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorAppointmentReminderPage()),
                      );
                    },
                    child: _buildIconColumn(Icons.medical_services, 'Appointments Reminder'),
                  ),

                ],
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showDoctorSubIcons = !_showDoctorSubIcons;
                      });
                    },
                    child: _buildIconColumn(Icons.local_hospital, 'Doctor'),
                  ),
                  SizedBox(width: 20),
                  _buildIconColumn(Icons.menu, 'More'),
                ],
              ),
              if (_showDoctorSubIcons) _buildDoctorSubIcons(),
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
                        style: TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
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

  Widget _buildDoctorSubIcons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                 if (id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MessageScreen( )),
                );
               } else {
                // Optionally show an error message if userId is null
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User ID is not available")),
                );
              }
            },
              child: _buildIconColumn(Icons.message, 'Message'),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserVideoPage()),
                );
              },
              child: _buildIconColumn(Icons.video_call, 'Video Call'),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AppointmentPage(username: widget.username)),
                );
              },
              child: _buildIconColumn(Icons.calendar_today, 'Appointment'),
            ),
          ],
        ),
      ],
    );
  }

  void _showAboutDialog(BuildContext context) {
    // Your about dialog code hereo

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
    final userProfile =
        await database.DatabaseHelper.instance.getUserProfile(widget.username);

    if (userProfile == null) {
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
              Text('Full Name: ${userProfile['full_name']}'),
              Text('Phone Number: ${userProfile['phone_number']}'),
              Text('Email: ${userProfile['email']}'),
              Text('Gender: ${userProfile['gender']}'),
              Text('Residence: ${userProfile['residence']}'),
              Text('Age: ${userProfile['age']}'),
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
