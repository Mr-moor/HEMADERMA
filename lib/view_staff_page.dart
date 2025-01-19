import 'package:flutter/material.dart';
import 'database_helper.dart'; // Make sure this points to your DatabaseHelper file

class ViewStaffPage extends StatefulWidget {
  @override
  _ViewStaffPageState createState() => _ViewStaffPageState();
}

class _ViewStaffPageState extends State<ViewStaffPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> _staffList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStaffDetails();
  }

  // Fetch staff details from the database
  Future<void> _fetchStaffDetails() async {
    setState(() {
      _isLoading = true;
    });

    List<Map<String, dynamic>> adminList = await _databaseHelper.queryAllAdmin();
    List<Map<String, dynamic>> doctorList = await _databaseHelper.queryAllDoctors();
    List<Map<String, dynamic>> labTechnicianList = await _databaseHelper.queryAllLabTechnicians();
    List<Map<String, dynamic>> pharmacistList = await _databaseHelper.queryAllPharmacists();

    setState(() {
      _staffList = [
        ...adminList,
        ...doctorList,
        ...labTechnicianList,
        ...pharmacistList,
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Staff'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _staffList.length,
              itemBuilder: (context, index) {
                final staff = _staffList[index];
                return ListTile(
                  title: Text(staff['full_name']),
                  subtitle: Text(staff['role']),
                  onTap: () {
                    _showStaffDetails(staff);
                  },
                );
              },
            ),
    );
  }

  // Display staff details in a dialog
  void _showStaffDetails(Map<String, dynamic> staff) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(staff['full_name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Phone: ${staff['phone_number']}'),
              Text('Email: ${staff['email']}'),
              Text('Address: ${staff['address']}'),
              Text('Role: ${staff['role']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
