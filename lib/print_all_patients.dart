import 'package:flutter/material.dart';
import 'patients_database_helper.dart';

class PrintAllPatientsPage extends StatefulWidget {
  final List<Map<String, dynamic>> patients; // Input parameter

  // Constructor to accept patients parameter
  PrintAllPatientsPage({required this.patients});

  @override
  _PrintAllPatientsPageState createState() => _PrintAllPatientsPageState();
}

class _PrintAllPatientsPageState extends State<PrintAllPatientsPage> {
  final dbHelper = PatientDatabaseHelper.instance;

  // List to hold all patients data
  List<Map<String, dynamic>> _patients = [];

  @override
  void initState() {
    super.initState();
    _patients = widget.patients; // Initialize _patients with the passed patients
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Patients'),
      ),
      body: _patients.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading spinner if no data yet
          : ListView.builder(
              itemCount: _patients.length,
              itemBuilder: (context, index) {
                final patient = _patients[index];
                return ListTile(
                  title: Text('${patient['full_name']} (ID: ${patient['id']})'),
                  subtitle: Text('Age: ${patient['age']} | Gender: ${patient['gender']}'),
                  trailing: Text('Phone: ${patient['phone_number']}'),
                );
              },
            ),
    );
  }
}
