import 'package:flutter/material.dart';
import 'patients_database_helper.dart';

class PrintSinglePatientPage extends StatelessWidget {
  final Map<String, dynamic> patient; // Patient data passed into the page

  PrintSinglePatientPage({required this.patient});

  // Method to print a single patient's information
  void _printSinglePatient(Map<String, dynamic> patient) {
    print('Patient ID: ${patient['id']}');
    print('Full Name: ${patient['full_name']}');
    print('Age: ${patient['age']}');
    print('Gender: ${patient['gender']}');
    print('Phone Number: ${patient['phone_number']}');
    print('Residence: ${patient['residence']}');
    print('Lab Test: ${patient['lab_test']}');
    print('Lab Result: ${patient['lab_result']}');
    print('Illness: ${patient['illness']}');
    print('Referred: ${patient['referred']}');
    print('Referred Hospital: ${patient['referred_hospital']}');
    print('Drug Prescribed: ${patient['drug_prescribed']}');
    print('Time: ${patient['time']}');
  }

  @override
  Widget build(BuildContext context) {
    // Print the patient information to the console (for debugging)
    _printSinglePatient(patient);

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient ID: ${patient['id']}'),
            Text('Full Name: ${patient['full_name']}'),
            Text('Age: ${patient['age']}'),
            Text('Gender: ${patient['gender']}'),
            Text('Phone Number: ${patient['phone_number']}'),
            Text('Residence: ${patient['residence']}'),
            Text('Lab Test: ${patient['lab_test']}'),
            Text('Lab Result: ${patient['lab_result']}'),
            Text('Illness: ${patient['illness']}'),
            Text('Referred: ${patient['referred']}'),
            Text('Referred Hospital: ${patient['referred_hospital']}'),
            Text('Drug Prescribed: ${patient['drug_prescribed']}'),
            Text('Time: ${patient['time']}'),
          ],
        ),
      ),
    );
  }
}
