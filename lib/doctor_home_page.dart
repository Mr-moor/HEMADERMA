import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemaderma/doctor_video_page.dart';
import 'package:hemaderma/patients_registration_page.dart';
import 'package:hemaderma/appointments_database.dart';
import 'package:hemaderma/doctor_message.dart';
import 'package:hemaderma/video_call_page.dart';
import 'package:hemaderma/phr_entry_page.dart';
import 'package:hemaderma/view_staff_page.dart';
import 'doctor_appointments_page.dart';
import 'doctor_view_appointments.dart';
import 'view_database_page.dart';
import 'doctor_video_page.dart';
import 'database_helper.dart' as database;
import 'doctor_message.dart';
import 'doctor_message.dart';
import 'phr_mangement.dart';


class DoctorHomePage extends StatefulWidget {
  final String username;

  DoctorHomePage({required this.username});

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  late Future<String> _quoteFuture;
  bool _showPatientSubIcons = false;
  int? id; // Variable to hold the userId

  @override
  void initState() {
    super.initState();
    _quoteFuture = _fetchQuote();
  }

  Future<String> _fetchQuote() async {
    await Future.delayed(Duration(seconds: 7));
    return '“To cure sometimes, to relieve often, to comfort always.”';
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Doctor Home Page'),
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
                'Welcome, Dr. ${widget.username}',
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
                        MaterialPageRoute(
                            builder: (context) => PatientForm()),
                      );
                    },
                    child: _buildIconColumn(Icons.person_add, 'Patient Reg.'),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewStaffPage()),
                      );
                    },
                    child: _buildIconColumn(Icons.group, 'View Staff'),
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
                        _showPatientSubIcons = !_showPatientSubIcons;
                      });
                    },
                    child: _buildIconColumn(Icons.local_hospital, 'Patients'),
                  ),

                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>PHRManagementPage(doctorUsername:'')),
                      );
                    },
                    child: _buildIconColumn(Icons.health_and_safety, 'Phr'),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
        builder: (context) => SharedPatientViewPage(userRole: 'Doctor')),

                      );
                    },
                    child: _buildIconColumn(Icons.medical_services, 'patients database'),
                  ),
                ],
              ),
              if (_showPatientSubIcons)
                _buildPatientSubIcons(),
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
    return scaffold;
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


  Widget _buildPatientSubIcons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                int doctorId;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorMessageScreen(doctorId: 1) ),
                );
              },
              child: _buildIconColumn(Icons.message, 'Messages'),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorVideoPage()),
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
                      builder: (context) => DoctorAvailableDatesPage()),
                );
              },
              child: _buildIconColumn(Icons.calendar_today, 'Appointments'),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoctorViewAppointmentsPage()),
                );
              },
              child: _buildIconColumn(Icons.calendar_today, 'Booked Appointments'),
            ),
          ],
        ),
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
              'Hemaderma is a platform for managing blood and skin-related diseases. It provides features such as patient registration, appointments, video calls, and more.'),
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
    final doctorProfile =
        await database.DatabaseHelper.instance.getDoctorProfile(widget.username);

    if (doctorProfile == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Profile Error'),
            content: Text('Unable to fetch doctor profile information.'),
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
              Text('Full Name: ${doctorProfile['full_name']}'),
              Text('Phone Number: ${doctorProfile['phone_number']}'),
              Text('Email: ${doctorProfile['email']}'),
              Text('Position: ${doctorProfile['Position']}'),
              Text('Residence: ${doctorProfile['residence']}'),
              Text('LicenceNumber: ${doctorProfile['licenceNumber']}'),
              Text('registratinNumber: ${doctorProfile['registrationNumber']}'),

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
