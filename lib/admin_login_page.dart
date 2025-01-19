import 'package:flutter/material.dart';
import 'package:hemaderma/database_helper.dart';
import 'package:hemaderma/admin_home_page.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  String _username = '';
  String _password = '';

  void _loginAdmin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Encrypt the password
      String hashedPassword = _dbHelper.hashPassword(_password);
      print('Hashed Password: $hashedPassword');

      // Query the admin data from the database
      Map<String, dynamic>? admin =
          await _dbHelper.queryAdmin(_username, hashedPassword);

      if (admin != null) {
        print('Admin found: ${admin['username']}');
        // If login is successful, navigate to Admin Home Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AdminHomePage(username: _username)),
        );
      } else {
        // Notify the user that login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onSaved: (value) => _username = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your username' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => _password = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your password' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginAdmin,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
