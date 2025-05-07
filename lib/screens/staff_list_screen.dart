import 'package:flutter/material.dart';

class StaffListScreen extends StatefulWidget {
  final List<Map<String, String>> existingStaff;

  const StaffListScreen({super.key, required this.existingStaff});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  late List<Map<String, String>> staffList;

  final _roles = ['Guard', 'CCTV-Guard', 'Manager', 'Inspector'];
  final _availabilityOptions = ['Yes-Available', 'Shift Assigned', 'On Leave'];

  @override
  void initState() {
    super.initState();
    staffList = List.from(widget.existingStaff);
  }

  void _addStaff() {
    String name = '';
    String role = _roles.first;
    String availability = _availabilityOptions.first;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Add Staff'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (val) => name = val,
              ),
              DropdownButtonFormField<String>(
                value: role,
                items:
                    _roles
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                onChanged: (val) => role = val!,
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              DropdownButtonFormField<String>(
                value: availability,
                items:
                    _availabilityOptions
                        .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                        .toList(),
                onChanged: (val) => availability = val!,
                decoration: const InputDecoration(labelText: 'Availability'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  setState(() {
                    staffList.add({
                      'name': name,
                      'role': role,
                      'availability': availability,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveAndReturn() {
    Navigator.pop(context, staffList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.only(right: 20),
        title: const Text('Staff List'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addStaff),
        ],
      ),
      body: ListView.builder(
        itemCount: staffList.length,
        itemBuilder: (_, index) {
          final staff = staffList[index];
          return ListTile(
            title: Text(staff['name'] ?? ''),
            subtitle: Text('${staff['role']} | ${staff['availability']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: _saveAndReturn,
        child: const Icon(Icons.save),
      ),
    );
  }
}
