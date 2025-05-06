// In shift_card.dart

import 'package:flutter/material.dart';
import '../models/shift.dart';
import 'package:hive/hive.dart';

class ShiftCard extends StatelessWidget {
  final Shift shift;
  final Function onDelete;

  const ShiftCard({super.key, required this.shift, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(shift.staffName),
        subtitle: Text(shift.time + "\n" + shift.date),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => onDelete(), // Call the onDelete function
        ),
      ),
    );
  }
}
