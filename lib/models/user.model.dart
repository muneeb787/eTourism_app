class User {
  int id;

  String username;
  String email;


  User({
    required this.id,

    required this.username,
    required this.email,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,

      username: json['username'] ?? "",
      email: json['email'] ?? "",

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'username': username,
      'email': email,

    };
  }
}