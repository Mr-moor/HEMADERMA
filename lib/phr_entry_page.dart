import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'phr_database_helper.dart';

class PHREntryPage extends StatefulWidget {
  final String username; // Patient's username

  PHREntryPage({required this.username});

  @override
  _PHREntryPageState createState() => _PHREntryPageState();
}

class _PHREntryPageState extends State<PHREntryPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  // Variables to hold form inputs
  String? _ambulatoryVisits, _hospitalizations, _allergies, _familyHistory;
  String? _immunizationRecords, _conditions, _medications, _surgeries;

  Future<void> _savePHR(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form values
      await _dbHelper.insertPHR({
        'username': widget.username,
        'ambulatory_visits': _ambulatoryVisits ?? '',
        'hospitalizations': _hospitalizations ?? '',
        'allergies': _allergies ?? '',
        'family_history': _familyHistory ?? '',
        'immunization_records': _immunizationRecords ?? '',
        'conditions': _conditions ?? '',
        'medications': _medications ?? '',
        'surgeries': _surgeries ?? '',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PHR saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Personal Health Record for ${widget.username}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildTextField('Previous Ambulatory Visits', (value) => _ambulatoryVisits = value),
              _buildTextField('Hospitalizations and Emergency Room Encounters', (value) => _hospitalizations = value),
              _buildTextField('Known Allergies', (value) => _allergies = value),
              _buildTextField('Family Medical History', (value) => _familyHistory = value),
              _buildTextField('Immunization Records', (value) => _immunizationRecords = value),
              _buildTextField('Current or Past Conditions', (value) => _conditions = value),
              _buildTextField('Medications', (value) => _medications = value),
              _buildTextField('Surgeries or Procedures', (value) => _surgeries = value),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _savePHR(context),
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A helper function to create text fields
  Widget _buildTextField(String label, Function(String?) onSaved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
