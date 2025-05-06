import 'package:hive/hive.dart';
part 'shift.g.dart';

@HiveType(typeId: 1)
class Shift extends HiveObject {
  @HiveField(0)
  String staffName;

  @HiveField(1)
  String date;

  @HiveField(2)
  String time;

  Shift({required this.staffName, required this.date, required this.time});
}
