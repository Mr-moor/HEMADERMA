import 'package:flutter/material.dart';
import 'package:hemaderma/database_helper.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username, _securityAnswer, _newPassword,password;
  String? _role = 'user'; // Default role as 'User'

  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Role'),
                value: _role,
                items: ['user', 'Doctor', 'Admin', 'pharmacist', 'lab_technician']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _role = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) => _username = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Security Answer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your security answer';
                  }
                  return null;
                },
                onSaved: (value) => _securityAnswer = value?.trim(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                onSaved: (value) => _newPassword = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    print('Role: $_role');
                    print('Username: $_username');
                    print('Security Answer: $_securityAnswer');
                    print('New Password: $_newPassword');

                   Map<String, dynamic>? foundUser;
                    if (_role == 'user') {
                      foundUser = await dbHelper.queryUser(_username!);
                    } else if (_role == 'doctor') {
                      // Removed password since it's not being used here
                       final hashedPassword = dbHelper.hashPassword(password!); // Add password variable
  foundUser = await dbHelper.queryDoctor(_username!,password!);
                    } else if (_role == 'Admin') {
                       final hashedPassword = dbHelper.hashPassword(password!); // Add password variable
  foundUser = await dbHelper.queryAdmin(_username!, password!);
                    } else if (_role == 'pharmacist') {
                       final hashedPassword = dbHelper.hashPassword(password!); // Add password variable
  foundUser = await dbHelper.querypharmacist(_username!, password!);
                    } else if (_role == 'lab_technician') {
                       final hashedPassword = dbHelper.hashPassword(password!); // Add password variable
  foundUser = await dbHelper.queryLabtechnician(_username!,password!);
                    }
                    print('User Data: $foundUser');
                    if (foundUser != null && foundUser['security_answer'] == _securityAnswer) {
                      final hashedPassword = dbHelper.hashPassword(_newPassword!);

String hashPassword(String password) {
  return sha256.convert(utf8.encode(password)).toString();
}
                      int result = 0;
                      if (_role == 'user') {
                        result = await dbHelper.updateUserPassword(_username!, hashedPassword);
                      } else if (_role == 'doctor') {
                        result = await dbHelper.updateDoctorPassword(_username!, hashedPassword,);
                      } else if (_role == 'Admin') {
                        result = await dbHelper.updateAdminPassword(_username!, hashedPassword);
                      } else if (_role == 'pharmacist') {
                        result = await dbHelper.updatePharmacistPassword(_username!, hashedPassword);
                      } else if (_role == 'lab_technician') {
                        result = await dbHelper.updateLabTechnicianPassword(_username!, hashedPassword);
                      }

                      if (result > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password reset successful')),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password reset failed')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid username or security answer')),
                      );
                    }
                  }
                },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
