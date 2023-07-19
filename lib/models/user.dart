class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime birthDate;
  final bool isActive;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
    required this.isActive,
  });
}
