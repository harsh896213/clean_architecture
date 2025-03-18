class User {
  final String id;
  final String email;
  final String name;
  final UserType type;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.type
  });
}

enum UserType { doctor, clinician, patient }
