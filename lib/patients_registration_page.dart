import 'package:flutter/material.dart';
import 'patients_database_helper.dart';

class PatientForm extends StatefulWidget {
  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  int _age = 0;
  String _gender = 'M'; // Default value
  String _phoneNumber = '';
  String _residence = '';
  String _labTest = '';
  String _labResult = '';
  String _illness = '';
  String _referred = 'No'; // Default value
  String _referredHospital = '';
  String _drug = '';
  late String _time;
 
  @override
  void initState() {
    super.initState();
    _time = DateTime.now().toIso8601String(); // Automatically generate time
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Insert patient data into the database
      await PatientDatabaseHelper.instance.insertPatient({
        'full_name': _fullName,
        'age': _age,
        'gender': _gender,
        'phone_number': _phoneNumber,
        'residence': _residence,
        'lab_test': _labTest,
        'lab_result': _labResult,
        'illness': _illness,
        'referred': _referred,
        'referred_hospital': _referredHospital,
        'drug_prescribed' : _drug,
        'time': _time,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Patient registered successfully!')),
      );
      _formKey.currentState!.reset(); // Reset form after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register Patient')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Full Name
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                onSaved: (value) => _fullName = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter full name';
                  return null;
                },
              ),
              // Age
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _age = int.parse(value!),
                validator: (value) {
                  if (value!.isEmpty || int.tryParse(value) == null) return 'Please enter valid age';
                  return null;
                },
              ),
              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: _gender,
                items: ['M', 'F'].map((label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                )).toList(),
                onChanged: (value) => setState(() => _gender = value!),
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              // Phone Number
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onSaved: (value) => _phoneNumber = value!,
                validator: (value) {
                  if (value!.isEmpty || value.length < 10) return 'Phone number must be at least 10 digits';
                  return null;
                },
              ),
              // Residence
              TextFormField(
                decoration: InputDecoration(labelText: 'Residence'),
                onSaved: (value) => _residence = value!,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter residence';
                  return null;
                },
              ),
              // Lab Test
              TextFormField(
                decoration: InputDecoration(labelText: 'Lab Test'),
                onSaved: (value) => _labTest = value!,
              ),
              // Lab Result
              TextFormField(
                decoration: InputDecoration(labelText: 'Lab Result'),
                onSaved: (value) => _labResult = value!,
              ),
              // Illness
              TextFormField(
                decoration: InputDecoration(labelText: 'Illness'),
                onSaved: (value) => _illness = value!,
              ),
              // Referred Dropdown
              DropdownButtonFormField<String>(
                value: _referred,
                items: ['Yes', 'No'].map((label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                )).toList(),
                onChanged: (value) => setState(() => _referred = value!),
                decoration: InputDecoration(labelText: 'Referred'),
              ),
              // Referred Hospital
              TextFormField(
                decoration: InputDecoration(labelText: 'Referred Hospital'),
                onSaved: (value) => _referredHospital = value!,
              ),
              TextFormField( 
                decoration: InputDecoration(labelText: 'drug prescribed'),
                onSaved: (value) => _drug = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
