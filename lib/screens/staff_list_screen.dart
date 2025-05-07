import 'package:flutter/material.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  final List<String> _staffMembers = ['John Doe', 'Alice Smith', 'Robert King'];

  void _addStaffMember(String name) {
    setState(() {
      _staffMembers.add(name);
    });
  }

  void _showAddStaffDialog() {
    String newName = '';
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add New Staff'),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Full Name'),
              onChanged: (value) {
                newName = value;
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (newName.trim().isNotEmpty) {
                    _addStaffMember(newName.trim());
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff List'),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddStaffDialog,
            tooltip: 'Add Staff',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _staffMembers.isEmpty
                ? const Center(child: Text('No staff members added yet.'))
                : ListView.builder(
                  itemCount: _staffMembers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          child: Text(_staffMembers[index][0]),
                        ),
                        title: Text(_staffMembers[index]),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              _staffMembers.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
