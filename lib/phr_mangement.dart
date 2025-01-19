import 'package:flutter/material.dart';
import 'phr_database_helper.dart';
import 'edit_phr_page.dart'; // Create a page for editing PHR records

class PHRManagementPage extends StatefulWidget {
  final String doctorUsername; // The doctor's username

  PHRManagementPage({required this.doctorUsername});

  @override
  _PHRManagementPageState createState() => _PHRManagementPageState();
}

class _PHRManagementPageState extends State<PHRManagementPage> {
  final dbHelper = DatabaseHelper.instance; // Assuming you have this in phr_database_helper.dart
  List<Map<String, dynamic>> phrRecords = [];

  @override
  void initState() {
    super.initState();
    _fetchPHRRecords();
  }

  void _fetchPHRRecords() async {
    List<Map<String, dynamic>> result = await dbHelper.getAllPHR(); // Fetch all PHR records
    setState(() {
      phrRecords = result;
    });
  }

  // Doctor actions
  void _editPHR(String username) async {
    final updatedPHR = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPHRPage(username: username)),
    );
    if (updatedPHR != null) {
      await dbHelper.updatePHR(username, updatedPHR);
      _fetchPHRRecords(); // Refresh the list
    }
  }

  // View individual PHR record
  void _viewPHR(String username) async {
    Map<String, dynamic>? phr = await dbHelper.getPHR(username);
    if (phr != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('PHR Details - $username'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ambulatory Visits: ${phr['ambulatory_visits'] ?? 'N/A'}'),
                  Text('Hospitalizations: ${phr['hospitalizations'] ?? 'N/A'}'),
                  Text('Allergies: ${phr['allergies'] ?? 'N/A'}'),
                  Text('Family History: ${phr['family_history'] ?? 'N/A'}'),
                  Text('Immunization Records: ${phr['immunization_records'] ?? 'N/A'}'),
                  Text('Conditions: ${phr['conditions'] ?? 'N/A'}'),
                  Text('Medications: ${phr['medications'] ?? 'N/A'}'),
                  Text('Surgeries: ${phr['surgeries'] ?? 'N/A'}'),
                ],
              ),
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

  // Build card for PHR records
  Widget _buildPHRCard(Map<String, dynamic> phrRecord) {
    String username = phrRecord['username'];
    return Card(
      child: ListTile(
        title: Text(username),
        subtitle: Text('Conditions: ${phrRecord['conditions'] ?? 'N/A'}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: () => _editPHR(username), child: Text('Edit')),
            ElevatedButton(onPressed: () => _viewPHR(username), child: Text('View')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor - PHR Management'),
      ),
      body: phrRecords.isNotEmpty
          ? ListView.builder(
              itemCount: phrRecords.length,
              itemBuilder: (context, index) {
                return _buildPHRCard(phrRecords[index]);
              },
            )
          : Center(child: Text('No PHR records available.')),
    );
  }
}
