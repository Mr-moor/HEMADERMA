import 'package:flutter/material.dart';
import 'patients_database_helper.dart';

class AddPatientPage extends StatefulWidget {
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final dbHelper = PatientDatabaseHelper.instance;

  // Controllers for form fields
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _residenceController = TextEditingController();
  final _illnessController = TextEditingController();
  final _referredController = TextEditingController();
  final _referredHospitalController = TextEditingController();
  final _labTestController = TextEditingController();
  final _drugController = TextEditingController();



  // Method to add a patient
  void _addPatient() async {
    // Gather patient data from the input fields
    Map<String, dynamic> patient = {
      'full_name': _nameController.text,
      'age': int.tryParse(_ageController.text) ?? 0,
      'gender': _genderController.text,
      'phone_number': _phoneNumberController.text,
      'residence': _residenceController.text,
      'lab_test': _labTestController.text,
      'referred': _referredController.text,
      'referred_hospital': _referredHospitalController.text,
      'drug_prescribed' : _drugController.text,
      'illness': _illnessController.text,
      'time': DateTime.now().toString(), // Automatically generated time
    };

    // Insert patient into the database
    await dbHelper.insertPatient(patient);

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Patient added successfully!')),
    );

    // Clear input fields after saving
    _nameController.clear();
    _ageController.clear();
    _genderController.clear();
    _phoneNumberController.clear();
    _residenceController.clear();
    _labTestController.clear();
    _referredController.clear();
    _referredHospitalController.clear();
    _drugController.clear();
    _illnessController.clear();

    // Optionally, navigate back to the previous page or refresh the patient list
    Navigator.pop(context); // Close the page after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender (M/F)'),
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _residenceController,
              decoration: InputDecoration(labelText: 'Residence'),
            ),
            TextField(
              controller: _illnessController,
              decoration: InputDecoration(labelText: 'Illness'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPatient, // Call the method when the button is pressed
              child: Text('Save Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
