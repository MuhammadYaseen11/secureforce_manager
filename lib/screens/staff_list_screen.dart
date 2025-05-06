import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/staff.dart';
import '../widgets/staff_card.dart';
import 'assign_shift_screen.dart';

class DummyStaffPage extends StatefulWidget {
  const DummyStaffPage({super.key});

  @override
  State<DummyStaffPage> createState() => _DummyStaffPageState();
}

class _DummyStaffPageState extends State<DummyStaffPage> {
  late Box<Staff> staffBox;

  @override
  void initState() {
    super.initState();
    staffBox = Hive.box<Staff>('staffBox');
  }

  void _deleteStaff(int index) {
    staffBox.deleteAt(index);
    setState(() {});
  }

  void _showOptions(Staff staff) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SizedBox(
          height: 150,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.calendar_month),
                title: Text("Assign Shift"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AssignShiftScreen(staffName: staff.name),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staff List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addStaffDialog(),
        child: Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: staffBox.listenable(),
        builder: (context, Box<Staff> box, _) {
          if (box.isEmpty) return Center(child: Text("No Staff Found"));

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final staff = box.getAt(index)!;
              return StaffCard(
                staff: staff,
                onTap: () => _showOptions(staff),
                onDelete: () => _deleteStaff(index),
              );
            },
          );
        },
      ),
    );
  }

  void _addStaffDialog() {
    final nameController = TextEditingController();
    final roleController = TextEditingController();
    final availabilityController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Add Staff"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: roleController,
                  decoration: InputDecoration(labelText: "Role"),
                ),
                TextField(
                  controller: availabilityController,
                  decoration: InputDecoration(labelText: "Availability"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final staff = Staff(
                    name: nameController.text,
                    role: roleController.text,
                    availability: availabilityController.text,
                  );
                  staffBox.add(staff);
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }
}
