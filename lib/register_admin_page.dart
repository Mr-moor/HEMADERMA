import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'database_helper.dart';

class RegisterAdminPage extends StatefulWidget {
  @override
  _RegisterAdminPageState createState() => _RegisterAdminPageState();
}

class _RegisterAdminPageState extends State<RegisterAdminPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _positionController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _securityQuestionController = TextEditingController();
  final _securityAnswerController = TextEditingController();
  bool _isTwoFactorEnabled = false;
  String _selectedRole = 'Register Doctor';

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Admin'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !validator.email(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
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
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _positionController,
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter position';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emergencyContactController,
                decoration: InputDecoration(labelText: 'Emergency Contact'),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 10) {
                    return 'Please enter a valid emergency contact number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _securityQuestionController,
                decoration: InputDecoration(labelText: 'Security Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a security question';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _securityAnswerController,
                decoration: InputDecoration(labelText: 'Security Answer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a security answer';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(labelText: 'Role'),
                items: <String>[
                  'Register Doctor',
                  'Register Lab Technician',
                  'View User Database and Profile',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
              ),
              SwitchListTile(
                title: Text('Enable Two-Factor Authentication'),
                value: _isTwoFactorEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isTwoFactorEnabled = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String hashedPassword =
                        _databaseHelper.hashPassword(_passwordController.text);
                    Map<String, dynamic> adminData = {
                      DatabaseHelper.columnFullName: _fullNameController.text,
                      DatabaseHelper.columnEmail: _emailController.text,
                      DatabaseHelper.columnPhoneNumber: _phoneController.text,
                      DatabaseHelper.columnPassword: hashedPassword,
                      DatabaseHelper.columnAddress: _addressController.text,
                      DatabaseHelper.columnPosition: _positionController.text,
                      DatabaseHelper.columnEmergencyContact:
                          _emergencyContactController.text,
                      DatabaseHelper.columnSecurityQuestion:
                          _securityQuestionController.text,
                      DatabaseHelper.columnSecurityAnswer:
                          _securityAnswerController.text,
                      DatabaseHelper.columnRole: _selectedRole,
                      DatabaseHelper.columnIsTwoFactorEnabled:
                          _isTwoFactorEnabled ? 1 : 0,
                    };
                    await _databaseHelper.insertAdmin(adminData);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Admin registered successfully!')),
                    );
                    _formKey.currentState!.reset();
                  }
                },
                child: Text('Register Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
