import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/staff.dart';
import '../widgets/staff_card.dart';

Future<List<Staff>> readJson() async {
  final String response = await rootBundle.loadString(
    'assets/data/dummy_staff.json',
  );
  final List<dynamic> data = json.decode(response);
  return data.map((e) => Staff.fromJson(e)).toList();
}

class DummyStaffPage extends StatelessWidget {
  const DummyStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staff List')),
      body: FutureBuilder<List<Staff>>(
        future: readJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final staffList = snapshot.data!;
            return ListView.builder(
              itemCount: staffList.length,
              itemBuilder: (context, index) {
                return StaffCard(staff: staffList[index]);
              },
            );
          }
        },
      ),
    );
  }
}
