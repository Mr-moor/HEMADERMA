import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'appointments_database.dart';

class DoctorAvailableDatesPage extends StatefulWidget {
  @override
  _DoctorAvailableDatesPageState createState() => _DoctorAvailableDatesPageState();
}

class _DoctorAvailableDatesPageState extends State<DoctorAvailableDatesPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<Map<String, dynamic>> _availableDates = [];
  final _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _fetchAvailableDates();
  }

  // Fetch the available dates from the database
  Future<void> _fetchAvailableDates() async {
    final dates = await _dbHelper.getAvailableDays();
    setState(() {
      _availableDates = dates;
    });
  }

  // Pick a date using the Flutter date picker
  Future<void> _pickDate(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Pick a time using the Flutter time picker (optional)
  Future<void> _pickTime(context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  // Save the selected date and time (optional) to the database
   Future<void> _saveDate(context) async {
    if (_selectedDate != null && _selectedTime != null) {
      String formattedDateTime =
          "${_selectedDate!.toLocal()} ${_selectedTime!.hour}:${_selectedTime!.minute}";
      await _dbHelper.insertAvailableDate({
        'date': formattedDateTime,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Date saved successfully!')),
      );
      _fetchAvailableDates(); // Refresh available dates list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both a date and time first.')),
      );
    }
  }

  // Delete a date from the available list

    Future<void> _deleteDate(int id,BuildContext context) async {
    await _dbHelper.deleteAvailableDate(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Date deleted successfully!')),
    );
    _fetchAvailableDates(); // Refresh available dates list
  }

  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Appointment Dates'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for the whole body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _pickDate(context),
              child: Text('Pick a Date'),
            ),
            SizedBox(height: 16), // Spacing between buttons
            ElevatedButton(
              onPressed: () => _pickTime(context),
              child: Text('Pick a Time'),
            ),
            SizedBox(height: 16), // Spacing between buttons
            ElevatedButton(
              onPressed:() =>_saveDate(context),
              child: Text('Save Date'),
            ),
            SizedBox(height: 16), // Spacing before the list
            Expanded(
              child: ListView.builder(
                itemCount: _availableDates.length,
                itemBuilder: (context, index) {
                  final date = _availableDates[index];
                  return ListTile(
                    title: Text('Available Date: ${date['date']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteDate(date['id'],context),
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