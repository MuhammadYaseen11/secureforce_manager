import 'package:flutter/material.dart';
import '../models/staff.dart';

class StaffCard extends StatelessWidget {
  final Staff staff;

  const StaffCard({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(staff.name),
        subtitle: Text('${staff.role} • ${staff.availability}'),
      ),
    );
  }
}
