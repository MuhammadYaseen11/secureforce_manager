import 'package:flutter/material.dart';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staff List')),
      body: Center(child: Text('Staff List will be displayed here.')),
    );
  }
}
