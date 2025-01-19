import 'package:flutter/material.dart';
import 'phr_database_helper.dart';

class PHRViewPage extends StatefulWidget {
  final String username;

  PHRViewPage({required this.username});

  @override
  _PHRViewPageState createState() => _PHRViewPageState();
}

class _PHRViewPageState extends State<PHRViewPage> {
  Map<String, dynamic>? _phrData;

  @override
  void initState() {
    super.initState();
    _fetchPHRData();
  }

  Future<void> _fetchPHRData() async {
    final data = await DatabaseHelper.instance.getPHR(widget.username);
    setState(() {
      _phrData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PHR Details for ${widget.username}')),
      body: _phrData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildDetail('Ambulatory Visits', _phrData!['ambulatory_visits']),
                  _buildDetail('Hospitalizations', _phrData!['hospitalizations']),
                  _buildDetail('Allergies', _phrData!['allergies']),
                  _buildDetail('Family History', _phrData!['family_history']),
                  _buildDetail('Immunization Records', _phrData!['immunization_records']),
                  _buildDetail('Conditions', _phrData!['conditions']),
                  _buildDetail('Medications', _phrData!['medications']),
                  _buildDetail('Surgeries', _phrData!['surgeries']),
                ],
              ),
            ),
    );
  }

  Widget _buildDetail(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? 'N/A'),
        ],
      ),
    );
  }
}
