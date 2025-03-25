class User {
  final String id;
  final String email;
  final String name;
  final UserType type;
  final String? specialty; // Added

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.type,
    this.specialty,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'type': type.index,
    'specialty': specialty,
  };
}

enum UserType { doctor, clinician, patient }
