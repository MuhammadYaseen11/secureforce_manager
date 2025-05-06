import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/shift.dart';

class AssignShiftScreen extends StatelessWidget {
  final String staffName;
  AssignShiftScreen({super.key, required this.staffName});

  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Assign Shift")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Assigning to: $staffName", style: TextStyle(fontSize: 18)),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: "Date"),
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(labelText: "Time"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final shift = Shift(
                  staffName: staffName,
                  date: dateController.text,
                  time: timeController.text,
                );
                Hive.box<Shift>('shiftBox').add(shift);
                Navigator.pop(context);
              },
              child: Text("Assign Shift"),
            ),
          ],
        ),
      ),
    );
  }
}
