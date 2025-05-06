import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/staff.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({super.key});

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _availabilityController = TextEditingController();

  void _saveStaff() async {
    final box = Hive.box<Staff>('staffBox');
    final newStaff = Staff(
      name: _nameController.text,
      role: _roleController.text,
      availability: _availabilityController.text,
    );
    await box.add(newStaff);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Staff")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _roleController,
              decoration: const InputDecoration(labelText: 'Role'),
            ),
            TextField(
              controller: _availabilityController,
              decoration: const InputDecoration(labelText: 'Availability'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveStaff, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
