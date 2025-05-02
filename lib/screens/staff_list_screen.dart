import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/staff.dart';

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
            //final staffList = snapshot.data!;
            final staffList =
                (snapshot.data as List<dynamic>)
                    .map((json) => Staff.fromJson(json))
                    .toList();
            return ListView.builder(
              itemCount: staffList.length,
              itemBuilder: (context, index) {
                final staff = staffList[index];
                return ListTile(
                  title: Text(staff.name),
                  subtitle: Text(
                    'Role: ${staff.role}\nAvailability: ${staff.availability}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
