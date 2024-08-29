class User {
  String id;
  String username;
  String name;
  String email;
  String? imageUrl;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? "",
      username: json['userName'] ?? "",
      name: json['Name'] ?? "",
      email: json['email'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
    );
  }

  factory User.fromJson2(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? "",
      username: json['username'] ?? "",
      name: json['Name'] ?? "",
      email: json['email'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'Name': name,
      'email': email,
      'imageUrl': imageUrl ?? "",
    };
  }
}
