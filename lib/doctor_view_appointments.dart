import 'package:flutter/material.dart';
import 'appointments_database.dart';

class DoctorViewAppointmentsPage extends StatefulWidget {
  @override
  _DoctorViewAppointmentsPageState createState() =>
      _DoctorViewAppointmentsPageState();
}

class _DoctorViewAppointmentsPageState
    extends State<DoctorViewAppointmentsPage> {
  List<Map<String, dynamic>> _appointments = [];
  final _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    final appointments = await _dbHelper.getAppointments();
    setState(() {
      _appointments = appointments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Booked Appointments'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _appointments.isEmpty
          ? Center(
              child: Text(
                'No appointments available.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _appointments.length,
                itemBuilder: (context, index) {
                  final appointment = _appointments[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        'Username: ${appointment['username']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Appointment Date: ${appointment['appointment_date']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Booked on: ${appointment['date']}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.calendar_today,
                        color: Colors.blueAccent,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
