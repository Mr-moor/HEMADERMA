import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

class DoctorAppointmentReminderPage extends StatefulWidget {
  @override
  _DoctorAppointmentReminderPageState createState() =>
      _DoctorAppointmentReminderPageState();
}

class _DoctorAppointmentReminderPageState
    extends State<DoctorAppointmentReminderPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TextEditingController doctorNameController = TextEditingController();
  TextEditingController clinicLocationController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    initializeNotifications();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification() async {
    if (selectedDate != null) {
      final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
        DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime.hour,
          selectedTime.minute,
        ),
        tz.local,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Doctor Appointment Reminder',
        'You have an appointment with Dr. ${doctorNameController.text} at ${clinicLocationController.text}.',
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your_channel_id',
            'your_channel_name',
            channelDescription: 'your_channel_description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
          ),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Appointment Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: doctorNameController,
              decoration: InputDecoration(labelText: 'Doctor\'s Name'),
            ),
            TextField(
              controller: clinicLocationController,
              decoration: InputDecoration(labelText: 'Clinic Location'),
            ),
            SizedBox(height: 20),
            Text("Selected Date: ${selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate!) : 'Not selected'}"),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Pick Date'),
            ),
            SizedBox(height: 20),
            Text("Reminder Time: ${selectedTime.format(context)}"),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Pick Time'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (doctorNameController.text.isNotEmpty &&
                    clinicLocationController.text.isNotEmpty &&
                    selectedDate != null) {
                  scheduleNotification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reminder Set!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields and select a date/time')),
                  );
                }
              },
              child: Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
