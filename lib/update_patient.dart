import 'package:flutter/material.dart';
import 'patients_database_helper.dart';

class UpdatePatientPage extends StatefulWidget {
  final int patientId; // This will be passed when navigating to this page

  UpdatePatientPage({required this.patientId});

  @override
  _UpdatePatientPageState createState() => _UpdatePatientPageState();
}

class _UpdatePatientPageState extends State<UpdatePatientPage> {
  final dbHelper = PatientDatabaseHelper.instance;

  // Controllers for form fields
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _residenceController = TextEditingController();
  final _labtestController = TextEditingController();
  final _illnessController = TextEditingController();
  final _referredController = TextEditingController();
  final _referredHospitalController = TextEditingController();

  // Method to update a patient
  void _updatePatient(int id) async {
    // Gather updated patient data from the input fields
    Map<String, dynamic> updatedPatient = {
      'full_name': _nameController.text,
      'age': int.tryParse(_ageController.text) ?? 0,
      'gender': _genderController.text,
      'phone_number': _phoneNumberController.text,
      'residence': _residenceController.text,
      'lab_test': _labtestController.text,
      'illness': _illnessController.text,
      'Referred': _referredController.text,
      'Referred_Hospital': _referredHospitalController.text,

      'time': DateTime.now().toString(), // Updated time
    };

    // Update patient in the database using their ID
    await dbHelper.updatePatient(id, updatedPatient);

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Patient updated successfully!')),
    );

    // Optionally, navigate back to the previous page or refresh the patient list
    Navigator.pop(context); // Close the page after updating
  }

  // Method to fetch existing patient data to populate input fields
  void _loadPatientData() async {
    var patientData = await dbHelper.getPatientById(widget.patientId);

    if (patientData != null) {
      // Populate controllers with existing patient data
      setState(() {
        _nameController.text = patientData['full_name'];
        _ageController.text = patientData['age'].toString();
        _genderController.text = patientData['gender'];
        _phoneNumberController.text = patientData['phone_number'];
        _residenceController.text = patientData['residence'];
        _labtestController.text = patientData['lab_test'];
        _illnessController.text = patientData['illness'];
        _referredController.text = patientData['Referred'];
        _referredHospitalController.text = patientData['Referred_Hospital'];

      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Load the patient data when the page is initialized
    _loadPatientData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Patient'),
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
              controller: _labtestController,
              decoration: InputDecoration(labelText: 'Lab_test'),
            ),

            TextField(
              controller: _illnessController,
              decoration: InputDecoration(labelText: 'Illness'),
            ),
            TextField(
              controller: _referredController,
              decoration: InputDecoration(labelText: 'Referred'),
            ),
            TextField(
              controller: _referredHospitalController,
              decoration: InputDecoration(labelText: 'Referred Hospital'),
            ),


            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _updatePatient(widget.patientId), // Call update method with patient ID
              child: Text('Update Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
