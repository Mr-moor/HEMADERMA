import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'appointments_database.dart';

class AppointmentPage extends StatefulWidget {
  final String username;

  AppointmentPage({required this.username});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  List<Map<String, dynamic>> _availableDays = [];
  final _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _fetchAvailableDays();
  }

  // Fetch available days from the database
  Future<void> _fetchAvailableDays() async {
    final days = await _dbHelper.getAvailableDays();
    setState(() {
      _availableDays = days;
    });
  }

  // Function to book an appointment
  Future<void> _bookAppointment(BuildContext context, int dayId, String date) async {
    // Check if the limit of 20 appointments for this day is reached
    final appointmentCount = await _dbHelper.getAppointmentCount(dayId);
    if (appointmentCount >= 20) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking limit exceeded for this day!')),
      );
      return;
    }

    // Book the appointment and save it to the database
    await _dbHelper.bookAppointment({
      'username': widget.username,
      'date': DateTime.now().toIso8601String(), // Booking time
      'appointment_date': date, // The chosen appointment date
      'day_id': dayId, // The reference to the available day
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appointment booked successfully!')),
    );

    // Refresh available dates after booking
    _fetchAvailableDays();
  }

  // Function to delete an appointment
  Future<void> _deleteAppointment(BuildContext context, int appointmentId) async {
    await _dbHelper.deleteAppointment(appointmentId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Appointment deleted successfully!')),
    );
    
    // Refresh available days after deletion
    _fetchAvailableDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book an Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _availableDays.isEmpty
                ? Center(child: Text('No available dates.'))
                : Expanded(
                    child: ListView.builder(
                      itemCount: _availableDays.length,
                      itemBuilder: (context, index) {
                        final day = _availableDays[index];
                        return ListTile(
                          title: Text('Available Date: ${day['date']}'),
                          subtitle: Text(
                            'Available slots: ${20 - day['appointments_count']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () =>
                                    _bookAppointment(context, day['id'], day['date']),
                                child: Text('Book'),
                              ),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  _deleteAppointment(context, day['id']);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
