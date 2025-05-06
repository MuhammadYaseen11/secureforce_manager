import 'package:hive/hive.dart';
part 'staff.g.dart';

@HiveType(typeId: 0)
class Staff extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String role;

  @HiveField(2)
  String availability;

  Staff({required this.name, required this.role, required this.availability});

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
    name: json['name'],
    role: json['role'],
    availability: json['availability'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'role': role,
    'availability': availability,
  };
}
