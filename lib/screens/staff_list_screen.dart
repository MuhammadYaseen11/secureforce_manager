import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<dynamic> readJson() async {
  final String response = await rootBundle.loadString(
    'assets/data/dummy_staff.json',
  );
  final data = await json.decode(response);
  return data;
}

class DummyStaffPage extends StatelessWidget {
  const DummyStaffPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dummy Staff List')),
      body: FutureBuilder(
        future: readJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // return Center(child: Text(snapshot.data.toString()));
            final staffList = snapshot.data!;
            return ListView.builder(
              itemCount: staffList.length,
              itemBuilder: (context, index) {
                final staff = staffList[index];
                final name = staff['name'];
                final role = staff['role'];
                final availability = staff['availability'];

                return ListTile(
                  title: Text(name),
                  subtitle: Text('Role: $role\nAvailability: $availability'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
