import 'package:flutter/material.dart';

class GenerateReportScreen extends StatelessWidget {
  final List<Map<String, String>> staffData;

  const GenerateReportScreen({super.key, required this.staffData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Report'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: staffData.length,
          itemBuilder: (_, index) {
            final staff = staffData[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(staff['name'] ?? 'Unnamed'),
                subtitle: Text(
                  'Role: ${staff['role']} | Availability: ${staff['availability']}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
