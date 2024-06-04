class User {
  int id;
  String name;
  String username;
  String email;
  String type;
  int companyId;
  int engineerId;
  String registrationNo;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.type,
    required this.companyId,
    required this.engineerId,
    required this.registrationNo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      type: json['type'] ?? "",
      companyId: json['company_id'] ?? 0,
      engineerId: json['engineer_id'] ?? 0,
      registrationNo: json['registration_no'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'type': type,
      'company_id': companyId,
      'engineer_id': engineerId,
      'registration_no': registrationNo,
    };
  }
}