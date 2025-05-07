import 'package:flutter/material.dart';

class AssignShiftScreen extends StatefulWidget {
  final List<Map<String, String>> staffList;

  const AssignShiftScreen({super.key, required this.staffList});

  @override
  State<AssignShiftScreen> createState() => _AssignShiftScreenState();
}

class _AssignShiftScreenState extends State<AssignShiftScreen> {
  String? _selectedStaff;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  void _pickTime(bool isStartTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
  }

  void _assignShift() {
    if (_selectedStaff != null && _startTime != null && _endTime != null) {
      // Optional: validate that end time is after start time
      final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
      final endMinutes = _endTime!.hour * 60 + _endTime!.minute;
      if (endMinutes <= startMinutes) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('End time must be after start time'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final assignedShift =
          '$_selectedStaff: ${_startTime!.format(context)} - ${_endTime!.format(context)}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Shift assigned to $_selectedStaff'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, assignedShift);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final names =
        widget.staffList.map((e) => e['name']).whereType<String>().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Shift'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedStaff,
              items:
                  names
                      .map(
                        (name) =>
                            DropdownMenuItem(value: name, child: Text(name)),
                      )
                      .toList(),
              onChanged: (value) => setState(() => _selectedStaff = value),
              decoration: const InputDecoration(labelText: 'Select Staff'),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                _startTime == null
                    ? 'Pick Start Time'
                    : 'Start Time: ${_startTime!.format(context)}',
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () => _pickTime(true),
            ),
            ListTile(
              title: Text(
                _endTime == null
                    ? 'Pick End Time'
                    : 'End Time: ${_endTime!.format(context)}',
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () => _pickTime(false),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _assignShift,
              icon: const Icon(Icons.check),
              label: const Text('Assign Shift'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
