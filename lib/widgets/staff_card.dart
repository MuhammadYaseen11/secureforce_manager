import 'package:flutter/material.dart';
import '../models/staff.dart';

class StaffCard extends StatelessWidget {
  final Staff staff;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const StaffCard({super.key, required this.staff, this.onTap, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(staff.name),
        subtitle: Text('${staff.role} • ${staff.availability}'),
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
