import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uni_links/uni_links.dart';
import 'login_page.dart';
import 'sign_up_page.dart';
import 'admin_registration_page.dart';
import 'admin_login_page.dart';
import 'package:timezone/data/latest.dart' as tz;
void main() {
  // Initialize the FFI database factory before running the app
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initUniLinks();
  }

  void _initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleIncomingLink(initialLink);
      }

      linkStream.listen((String? link) {
        if (link != null) {
          _handleIncomingLink(link);
        }
      });
    } on Exception {
      // Handle exception by warning the user their action did not succeed
    }
  }

  void _handleIncomingLink(String link) {
    if (link.startsWith('hemadermaadmin://register')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminRegistrationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hemaderma',
      theme: ThemeData(
        
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white, // Use scaffoldBackgroundColor instead of backgroundColor
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // Changed from bodyText1 to bodyLarge
    titleLarge: TextStyle(color: Colors.white), // Changed from headline6 to titleLarge
  ),
),
 debugShowCheckedModeBanner: false, // Disabling the debug banner
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/sign_up': (context) => SignUpPage(),
        '/admin-register': (context) => AdminRegistrationPage(),
        '/admin-login': (context) => AdminLoginPage(),
      },
    );
  }
}
