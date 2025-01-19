import 'package:flutter/material.dart';
import 'phr_database_helper.dart';

class EditPHRPage extends StatefulWidget {
  final String username; // The username of the patient whose PHR is being edited

  EditPHRPage({required this.username});

  @override
  _EditPHRPageState createState() => _EditPHRPageState();
}

class _EditPHRPageState extends State<EditPHRPage> {
  final dbHelper = DatabaseHelper.instance;

  // Controllers for editing PHR fields
  final TextEditingController ambulatoryVisitsController = TextEditingController();
  final TextEditingController hospitalizationsController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController familyHistoryController = TextEditingController();
  final TextEditingController immunizationRecordsController = TextEditingController();
  final TextEditingController conditionsController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  final TextEditingController surgeriesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPHRData();
  }

  // Load the existing PHR data for the user
  void _loadPHRData() async {
    Map<String, dynamic>? phr = await dbHelper.getPHR(widget.username);
    if (phr != null) {
      setState(() {
        ambulatoryVisitsController.text = phr['ambulatory_visits'] ?? '';
        hospitalizationsController.text = phr['hospitalizations'] ?? '';
        allergiesController.text = phr['allergies'] ?? '';
        familyHistoryController.text = phr['family_history'] ?? '';
        immunizationRecordsController.text = phr['immunization_records'] ?? '';
        conditionsController.text = phr['conditions'] ?? '';
        medicationsController.text = phr['medications'] ?? '';
        surgeriesController.text = phr['surgeries'] ?? '';
      });
    }
  }

  // Save the updated PHR data
  void _savePHRData() async {
    Map<String, dynamic> updatedPHR = {
      'ambulatory_visits': ambulatoryVisitsController.text,
      'hospitalizations': hospitalizationsController.text,
      'allergies': allergiesController.text,
      'family_history': familyHistoryController.text,
      'immunization_records': immunizationRecordsController.text,
      'conditions': conditionsController.text,
      'medications': medicationsController.text,
      'surgeries': surgeriesController.text,
    };

    await dbHelper.updatePHR(widget.username, updatedPHR);
    Navigator.pop(context, updatedPHR); // Return to the previous screen with updated data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit PHR for ${widget.username}'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _savePHRData, // Save PHR when pressed
            tooltip: 'Save PHR',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ambulatory Visits', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: ambulatoryVisitsController, decoration: InputDecoration(hintText: 'Ambulatory Visits')),
            
            SizedBox(height: 16.0),
            Text('Hospitalizations', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: hospitalizationsController, decoration: InputDecoration(hintText: 'Hospitalizations')),

            SizedBox(height: 16.0),
            Text('Allergies', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: allergiesController, decoration: InputDecoration(hintText: 'Allergies')),

            SizedBox(height: 16.0),
            Text('Family Medical History', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: familyHistoryController, decoration: InputDecoration(hintText: 'Family Medical History')),

            SizedBox(height: 16.0),
            Text('Immunization Records', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: immunizationRecordsController, decoration: InputDecoration(hintText: 'Immunization Records')),

            SizedBox(height: 16.0),
            Text('Conditions', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: conditionsController, decoration: InputDecoration(hintText: 'Conditions')),

            SizedBox(height: 16.0),
            Text('Medications', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: medicationsController, decoration: InputDecoration(hintText: 'Medications')),

            SizedBox(height: 16.0),
            Text('Surgeries', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: surgeriesController, decoration: InputDecoration(hintText: 'Surgeries')),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    ambulatoryVisitsController.dispose();
    hospitalizationsController.dispose();
    allergiesController.dispose();
    familyHistoryController.dispose();
    immunizationRecordsController.dispose();
    conditionsController.dispose();
    medicationsController.dispose();
    surgeriesController.dispose();
    super.dispose();
  }
}
