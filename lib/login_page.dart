import 'package:flutter/material.dart';
import 'package:hemaderma/database_helper.dart' as database;
import 'forgot_password_page.dart';
import 'sign_up_page.dart';
import 'user_home_page.dart';
import 'admin_home_page.dart';
import 'doctor_home_page.dart';
import 'lab_technician_home_page.dart';
import 'pharmacist_home_page.dart';
import 'admin_registration_page.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'message_database.dart' as data;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _loginStatus = '';

  // Function to hash the password using SHA-256
  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  void _login() async {
    final dbHelper = database.DatabaseHelper.instance;
    int userId=0;
    final fetchedUserId = await dbHelper.getCurrentUserId(userId);// Update this to your method

    // Get the input values
    String username = _usernameController.text;
    String password = _passwordController.text;
SharedPreferences prefs = await SharedPreferences.getInstance();
if (fetchedUserId != null) {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', fetchedUserId);
} else {
  print("Error: fetchedUserId is null");
}

    try {
      // Ensure both username and password are provided
      if (username.isEmpty || password.isEmpty) {
        setState(() {
          _loginStatus = 'Please enter both username and password.';
        });
        return;
      }



      // Hash the input password to compare with stored password
      final hashedPassword = hashPassword(password);
print('Hashed Password: $hashedPassword');  

      // Query the database for the user roles
      final admin = await dbHelper.queryAdmin(username, password);
      final doctor = await dbHelper.queryDoctor(username, password);
      final pharmacist = await dbHelper.querypharmacist(username, password);
      final labTechnician = await dbHelper.queryLabtechnician(username, password);
      final user = await dbHelper.queryUser(username);
      
      // Determine which user role is found, prioritize the role
      final foundUser = admin ?? doctor ?? pharmacist ?? labTechnician ?? user;
      // Debugging
      print('Admin: $admin');
      print('Doctor: $doctor');
      print('Pharmacist: $pharmacist');
      print('Lab Technician: $labTechnician');
      print('user:$user');

      if (foundUser == null) {
        // If no user is found
        setState(() {
          _loginStatus = 'Invalid username or password.';
        });
        return;
      }
      else
      setState(() { 
        
        _loginStatus = 'Login successful!';
        
      });

      // Get the user role to navigate to the correct home page
      String role = foundUser[database.DatabaseHelper.columnRole];
 print('User Role: $role'); 

      // Navigate to the correct home page based on role
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (role == 'Admin') {
              return AdminHomePage(username: username);
            } else if (role == 'Doctor') {
              return DoctorHomePage(username: username);
            } else if (role == 'lab_technician') {
              return LabTechnicianHomePage(username: username);
            } else if (role == 'pharmacist') {
              return PharmacistHomePage(username: username);
            } else {
              
              return UserHomePage(username:username); // Default user role
              
            }
          },
        ),
      );
    } catch (e) {
      setState(() {
        _loginStatus = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Hemaderma',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Enhancing life Through Technology',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Image.asset(
                    'assets/images/steth.png',
                    height: 80,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _loginStatus,
                    style: TextStyle(
                      color: _loginStatus == 'Login successful!' ? Colors.white : Colors.red,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Text('Forgot Password?'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
          // Hidden admin registration button
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminRegistrationPage()),
                );
              },
              child: Container(
                width: 20,
                height: 20,
                color: Colors.transparent, // Invisible button
              ),
            ),
          ),
        ],
      ),
    );
  }
}
