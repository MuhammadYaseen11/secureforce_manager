import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class StaffListScreen extends StatelessWidget {
  const StaffListScreen({super.key});

  Future<List<dynamic>> loadStaff() async {
    final data = await rootBundle.loadString('assets/data/dummy_staff.json');
    return json.decode(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staff List')),
      body: FutureBuilder(
        future: loadStaff(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');

          final staffList = snapshot.data!;
          return ListView.builder(
            itemCount: staffList.length,
            itemBuilder: (context, index) {
              final staff = staffList[index];
              return ListTile(
                title: Text(staff['name']),
                subtitle: Text('${staff['role']} - ${staff['availability']}'),
              );
            },
          );
        },
      ),
    );
  }
}
