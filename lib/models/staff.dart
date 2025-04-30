class Staff {
  final int id;
  final String name;
  final String role;
  final String availability;

  Staff({
    required this.id,
    required this.name,
    required this.role,
    required this.availability,
  });
  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      availability: json['availability'],
    );
  }
}
