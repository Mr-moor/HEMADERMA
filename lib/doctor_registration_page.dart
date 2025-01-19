import 'package:flutter/material.dart';
import 'database_helper.dart';

class DoctorRegistrationPage extends StatefulWidget {
  @override
  _DoctorRegistrationPageState createState() => _DoctorRegistrationPageState();
}

class _DoctorRegistrationPageState extends State<DoctorRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _address = '';
  String _position = '';
  String _securityQuestion = '';
  String _securityAnswer = '';
  String _emergencyContact = '';
  String _role = 'Doctor'; // Default role for doctor registration
  String _username = '';
  String _password = '';
  String _registrationNumber = '';
  String _licenseNumber = '';
  String _status = 'ACTIVE';
  bool _istwoFactorEnabled = false;

  Future<void> _registerDoctor() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String hashedPassword = _dbHelper.hashPassword(_password);
      
      Map<String, dynamic> doctorData = {
        DatabaseHelper.columnFullName: _fullName,
        DatabaseHelper.columnEmail: _email,
        DatabaseHelper.columnPhoneNumber: _phoneNumber,
        DatabaseHelper.columnAddress: _address,
        DatabaseHelper.columnPosition: _position,
        DatabaseHelper.columnSecurityQuestion: _securityQuestion,
        DatabaseHelper.columnSecurityAnswer: _securityAnswer,
        DatabaseHelper.columnEmergencyContact: _emergencyContact,
        DatabaseHelper.columnRole: _role,
        DatabaseHelper.columnUsername: _username,
        DatabaseHelper.columnPassword: hashedPassword,
        DatabaseHelper.columnRegistrationNumber: _registrationNumber,
        DatabaseHelper.columnLicenseNumber: _licenseNumber,
        DatabaseHelper.columnStatus: _status,
        DatabaseHelper.columnIsTwoFactorEnabled: _istwoFactorEnabled ? 1 : 0,
      };


      await _dbHelper.insertDoctor(doctorData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Doctor registered successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctor Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter the full name' : null,
                onSaved: (value) => _fullName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the email';
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the phone number';
                  } else if (value.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter the address' : null,
                onSaved: (value) => _address = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter the position' : null,
                onSaved: (value) => _position = value!,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Security Question'),
                value: _securityQuestion.isNotEmpty
                    ? _securityQuestion
                    : null, // Set to null if not selected
                items: [
                  'What was your childhood nickname?',
                  'What is the name of your first pet?',
                  'What is your mother\'s maiden name?',
                ].map((question) {
                  return DropdownMenuItem(
                    value: question,
                    child: Text(question),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select a security question' : null,
                onChanged: (value) =>
                    setState(() => _securityQuestion = value ?? ''),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Security Answer'),
                validator: (value) => value!.isEmpty
                    ? 'Please enter the answer to the security question'
                    : null,
                onSaved: (value) => _securityAnswer = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Emergency Contact'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the emergency contact';
                  } else if (value.length != 10) {
                    return 'Emergency contact must be 10 digits';
                  }
                  return null;
                },
                onSaved: (value) => _emergencyContact = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter the username' : null,
                onSaved: (value) => _username = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the password';
                  } else if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                      .hasMatch(value)) {
                    return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Registration Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the registration number';
                  } else if (value.length != 5) {
                    return 'Registration number must be 5 digits';
                  }
                  return null;
                },
                onSaved: (value) => _registrationNumber = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Licence Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the licence number';
                  } else if (value.length != 10) {
                    return 'Licence number must be 10 characters';
                  }
                  return null;
                },
                onSaved: (value) => _licenseNumber = value!,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Status'),
                value: _status.isNotEmpty
                    ? _status
                    : null, // Set to null if not selected
                items: ['ACTIVE', 'EXPIRED'].map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select a status' : null,
                onChanged: (value) => setState(() => _status = value ?? ''),
              ),
              
              SwitchListTile(
                title: Text('Enable Two-Factor Authentication'),
                value: _istwoFactorEnabled,
                onChanged: (value) {
                  setState(() {
                    _istwoFactorEnabled = value;
                  });
                },
              ),
              
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerDoctor,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
