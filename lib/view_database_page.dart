import 'package:flutter/material.dart';
import 'patients_database_helper.dart';
import 'print_single_user.dart';
import 'print_all_patients.dart';
import 'add_patient_page.dart';
import 'update_patient.dart';

class SharedPatientViewPage extends StatefulWidget {
  final String userRole; // Role: Doctor, Lab Technician, Pharmacist, Admin

  SharedPatientViewPage({required this.userRole});

  @override
  _SharedPatientViewPageState createState() => _SharedPatientViewPageState();
}

class _SharedPatientViewPageState extends State<SharedPatientViewPage> {
  final dbHelper = PatientDatabaseHelper.instance;

  List<Map<String, dynamic>> patients = [];

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  void _fetchPatients() async {
    List<Map<String, dynamic>> result = await dbHelper.getAllPatients();
    setState(() {
      patients = result;
    });
  }

  // Doctor actions
  void _addPatient() async {
    final newPatient = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPatientPage()),
    );
    if (newPatient != null) {
      await dbHelper.insertPatient(newPatient);
      _fetchPatients(); // Refresh list
    }
  }

  void _updatePatient(int id) async {
    final updatedPatient = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdatePatientPage(patientId: id)),
    );
    if (updatedPatient != null) {
      await dbHelper.updatePatient(id, updatedPatient);
      _fetchPatients(); // Refresh list
    }
  }

  void _deletePatient(int id) async {
    await dbHelper.deletePatient(id);
    _fetchPatients(); // Refresh list
  }

  // Lab technician actions
  void _insertLabResult(int id) async {
    // Open a dialog or a new page to get the lab result
    String? labResult = await showDialog(
      context: context,
      builder: (context) {
        String result = '';
        return AlertDialog(
          title: Text('Insert Lab Result'),
          content: TextField(
            onChanged: (value) {
              result = value;
            },
            decoration: InputDecoration(hintText: "Lab Result"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(result);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
    if (labResult != null && labResult.isNotEmpty) {
      await dbHelper.updatePatient(id, {'lab_result': labResult});
      _fetchPatients(); // Refresh list
    }
  }

  void _deleteLabResult(int id) async {
    await dbHelper.updatePatient(id, {'lab_result': ''});
    _fetchPatients(); // Refresh list
  }

  // Pharmacist action
  void _insertDrugPrescription(int id) async {
    String? drug = await showDialog(
      context: context,
      builder: (context) {
        String prescription = '';
        return AlertDialog(
          title: Text('Insert Drug Prescription'),
          content: TextField(
            onChanged: (value) {
              prescription = value;
            },
            decoration: InputDecoration(hintText: "Drug Prescribed"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(prescription);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
    if (drug != null && drug.isNotEmpty) {
      await dbHelper.updatePatient(id, {'drug_prescribed': drug});
      _fetchPatients(); // Refresh list
    }
  }

  // Print actions (for Doctor)
  void _printAllPatients() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrintAllPatientsPage(patients: patients),
      ),
    );
  }

  void _printSinglePatient(Map<String, dynamic> patient) {
    print('Navigating to print single patient page with patient data: $patient');
    // Navigate to the PrintSinglePatientPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrintSinglePatientPage(patient: patient),
      ),
    );
  }

  // Role-based widgets
  Widget _doctorActions(int id, Map<String, dynamic> patient) {
  return SingleChildScrollView( // Use SingleChildScrollView to prevent overflow
    scrollDirection: Axis.horizontal, // Allows horizontal scrolling if necessary
    child: Row(
      children: [
        ElevatedButton(onPressed: () => _updatePatient(id), child: Text('Update')),
        ElevatedButton(onPressed: () => _deletePatient(id), child: Text('Delete')),
        ElevatedButton(onPressed: () => _printSinglePatient(patient), child: Text('Print Patient Data')),
        ElevatedButton(onPressed: () => _printAllPatients(), child: Text('Print all Patients Data')),

      ],
    ),
  );
}

  Widget _labTechnicianActions(int id) {
    return SingleChildScrollView(
       scrollDirection: Axis.horizontal, 
       child: Row(
      children: [
        ElevatedButton(
            onPressed: () => _insertLabResult(id),
            child: Text('Insert Lab Result')),
        ElevatedButton(onPressed: () => _deleteLabResult(id), child: Text('Delete Lab Result')),
      ],
       ),
    );
  }

  Widget _pharmacistActions(int id) {
    return ElevatedButton(
        onPressed: () => _insertDrugPrescription(id),
        child: Text('Insert Drug Prescription'));
  }

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    int id = patient['id'];
    return Card(
      child: ListTile(
        title: Text(patient['full_name']),
        subtitle: Text('Age: ${patient['age']} | Gender: ${patient['gender']}'),
        onTap: () {
          // Navigate to detailed view of single patient if needed
        },
        trailing: Column(
          children: [
            if (widget.userRole == 'Doctor') _doctorActions(id, patient),
            if (widget.userRole == 'Lab Technician') _labTechnicianActions(id),
            if (widget.userRole == 'Pharmacist') _pharmacistActions(id),
            if (widget.userRole == 'Admin') Text('View Only')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.userRole} - Patient Management'),
        actions: [
          if (widget.userRole == 'Doctor') 
            IconButton(onPressed: _printAllPatients, icon: Icon(Icons.print)),
        ],
      ),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          return _buildPatientCard(patients[index]);
        },
      ),
      floatingActionButton: widget.userRole == 'Doctor'
          ? FloatingActionButton(
              onPressed: _addPatient, 
              child: Icon(Icons.add),
              tooltip: 'Add Patient',
            )
          : null,
    );
  }
}
