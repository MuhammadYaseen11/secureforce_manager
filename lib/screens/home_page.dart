import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secureforce_manager/models/shift.dart';
import 'package:secureforce_manager/models/staff.dart';
import 'package:secureforce_manager/screens/add_staff_screen.dart';
import 'package:secureforce_manager/screens/assign_shift_screen.dart';
import 'package:secureforce_manager/screens/staff_list_screen.dart';
import 'package:secureforce_manager/widgets/shift_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final staffBox = Hive.box<Staff>('staffBox');
    final shiftBox = Hive.box<Shift>('shiftBox');

    // Method to delete shift from the shift box
    void _deleteShift(int index) {
      shiftBox.deleteAt(index); // Removes the shift at the given index
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Manager',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DummyStaffPage()),
                    );
                  },
                  child: Text('View Staff'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddStaffScreen()),
                    );
                  },
                  child: Text('Add Staff'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AssignShiftScreen(staffName: ''),
                      ),
                    );
                  },
                  child: Text('Assign Shift'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Generate Report'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Staff Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Total Staff: ${staffBox.length}'),

            SizedBox(height: 20),
            Text(
              'Upcoming Shifts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ValueListenableBuilder(
              valueListenable: shiftBox.listenable(),
              builder: (context, Box<Shift> box, _) {
                if (box.isEmpty) return Text("No upcoming shifts");
                return Column(
                  children:
                      box.values.map((e) {
                        int shiftIndex = box.values.toList().indexOf(
                          e,
                        ); // Get index of shift
                        return ShiftCard(
                          shift: e,
                          onDelete:
                              () => _deleteShift(
                                shiftIndex,
                              ), // Pass delete method
                        );
                      }).toList(),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Shift assignments will appear here."),
          ],
        ),
      ),
    );
  }
}
