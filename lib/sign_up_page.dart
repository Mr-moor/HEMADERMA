import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'database_helper.dart';
import 'user_home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedGender = 'M';
  String _selectedResidence = 'Nairobi Central';
  DateTime _selectedDateOfBirth = DateTime.now();
  final _securityAnswerController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _role = 'user';
  String _statusMessage = '';

  final List<String> _genders = ['M', 'F'];
  final List<String> _residences = [
    'Nairobi Central',
    '',
    'Makina',
    'lindi',
    'Gatwekera',
    'darajani',
    'laini-saba',
    'mashimoni',
    'woodley',
    '42',
    'olympic',
    'ayani',
    'undugu',
    'silanga',
    'kichinjio'
  ];
  final List<String> _securityQuestions = [
    "What's your favorite pet?",
    "What's your best friend's name?",
    "What's the name of the road you grew up on?"
  ];
  String? _selectedQuestion;

  void _signUp() async {
    final dbHelper = DatabaseHelper.instance;

    if (!_formKey.currentState!.validate()) {
      setState(() {
        _statusMessage = 'Please fill in all fields correctly.';
      });
      return;
    }

    final user = await dbHelper.queryUser(_usernameController.text);
    if (user != null) {
      setState(() {
        _statusMessage = 'Username already exists.';
      });
      return;
    }

    final newUser = {
      DatabaseHelper.columnFullName: _fullNameController.text,
      DatabaseHelper.columnPhoneNumber: _phoneNumberController.text,
      DatabaseHelper.columnEmail: _emailController.text,
      DatabaseHelper.columnGender: _selectedGender,
      DatabaseHelper.columnResidence: _selectedResidence,
      DatabaseHelper.columnAge: _calculateAge(_selectedDateOfBirth),
      DatabaseHelper.columnSecurityQuestion: _selectedQuestion,
      DatabaseHelper.columnSecurityAnswer: _securityAnswerController.text,
      DatabaseHelper.columnUsername: _usernameController.text,
      DatabaseHelper.columnPassword:
          dbHelper.hashPassword(_passwordController.text),
      DatabaseHelper.columnRole: _role,
    };

    int result = await dbHelper.insertUser(newUser);
    setState(() {
      _statusMessage = result > 0
          ? 'Sign up successful!'
          : 'Sign up failed. Please try again.';
    });

    // Navigate to UserHomePage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserHomePage(username: _usernameController.text),
      ),
    );
  }

  String _calculateAge(DateTime dateOfBirth) {
    int age = DateTime.now().year - dateOfBirth.year;
    if (DateTime.now().month < dateOfBirth.month ||
        (DateTime.now().month == dateOfBirth.month &&
            DateTime.now().day < dateOfBirth.day)) {
      age--;
    }
    return age.toString();
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty || value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value)) {
      return 'Password must contain upper, lower case letters, numbers, and special characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: _validatePhoneNumber,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                value: _selectedGender,
                items: _genders.map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Residence'),
                value: _selectedResidence,
                items: _residences.map((String residence) {
                  return DropdownMenuItem<String>(
                    value: residence,
                    child: Text(residence),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedResidence = newValue!;
                  });
                },
              ),
              ListTile(
                title: Text('Date of Birth'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDateOfBirth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != _selectedDateOfBirth)
                    setState(() {
                      _selectedDateOfBirth = pickedDate;
                    });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Security Question'),
                value: _selectedQuestion,
                items: _securityQuestions.map((String question) {
                  return DropdownMenuItem<String>(
                    value: question,
                    child: Text(question),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedQuestion = newValue!;
                  });
                },
              ),
              TextFormField(
                controller: _securityAnswerController,
                decoration: InputDecoration(labelText: 'Security Answer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide an answer to the security question';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20),
              Text(
                _statusMessage,
                style: TextStyle(
                  color: _statusMessage.contains('successful')
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
