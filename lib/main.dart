import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secureforce_manager/models/shift.dart';
import 'models/staff.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StaffAdapter());
  Hive.registerAdapter(ShiftAdapter());
  await Hive.openBox<Staff>('staffBox');
  await Hive.openBox<Shift>('shiftBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staff Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}
