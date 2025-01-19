import 'package:flutter/material.dart';
import 'package:hemaderma/database_helper.dart';
import 'package:hemaderma/admin_home_page.dart';

class AdminRegistrationPage extends StatefulWidget {
  @override
  _AdminRegistrationPageState createState() => _AdminRegistrationPageState();
}

class _AdminRegistrationPageState extends State<AdminRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  String _fullName = '';
  String _email = '';
  String _phoneNumber = '';
  String _username = '';
  String _password = '';
  String _address = '';
  String _position = '';
  String _emergencyContact = '';
  String _securityAnswer = '';
  String _role = 'Admin';
  bool _isTwoFactorEnabled = false;

  final List<String> _securityQuestion = [
    "What's your favorite pet?",
    "What's your best friend's name?",
    "What's the name of the road you grew up on?"
  ];
  String? _selectedQuestion;

  void _registerAdmin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Encrypt the password
      String hashedPassword = _dbHelper.hashPassword(_password);

      // Prepare admin data
      Map<String, dynamic> adminData = {
        DatabaseHelper.columnFullName: _fullName,
        DatabaseHelper.columnEmail: _email,
        DatabaseHelper.columnPhoneNumber: _phoneNumber,
        DatabaseHelper.columnUsername: _username,
        DatabaseHelper.columnPassword: hashedPassword,
        DatabaseHelper.columnAddress: _address,
        DatabaseHelper.columnPosition: _position,
        DatabaseHelper.columnEmergencyContact: _emergencyContact,
        DatabaseHelper.columnSecurityQuestion: _selectedQuestion,
        DatabaseHelper.columnSecurityAnswer: _securityAnswer,
        DatabaseHelper.columnRole: _role,
        DatabaseHelper.columnIsTwoFactorEnabled: _isTwoFactorEnabled ? 1 : 0,
      };

      // Insert admin data into the database
      await _dbHelper.insertAdmin(adminData);

      // Notify user of success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Admin Registered Successfully!')),
      );

      // Navigate to Admin Home Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AdminHomePage(username: _username)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeAdminDatabase();
  }

  void _initializeAdminDatabase() async {
    await _dbHelper.adminDatabase;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                onSaved: (value) => _fullName = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter full name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                onSaved: (value) => _phoneNumber = value!,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                onSaved: (value) => _username = value!,
                validator: (value) =>
                    value!.isEmpty ? 'please enter your username' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => _password = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (!RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                      .hasMatch(value)) {
                    return 'Password must contain upper, lower case letters, numbers, and special characters';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value != _password) return 'Passwords do not match';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                onSaved: (value) => _address = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter address' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Position'),
                onSaved: (value) => _position = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter position' : null,
              ),
              TextFormField(
                  decoration: InputDecoration(labelText: 'Emergency Contact'),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => _emergencyContact = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 10) {
                      return 'Please enter a valid emergency contact number';
                    }
                    return null;
                  }),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Security Question'),
                value: _selectedQuestion,
                items: _securityQuestion.map((String question) {
                  return DropdownMenuItem<String>(
                    value: question,
                    child: Text(question),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedQuestion = newValue;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Security Answer'),
                onSaved: (value) => _securityAnswer = value!,
              ),
              SwitchListTile(
                title: Text('Enable Two-Factor Authentication'),
                value: _isTwoFactorEnabled,
                onChanged: (value) {
                  setState(() {
                    _isTwoFactorEnabled = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: _registerAdmin,
                child: Text('Register Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
