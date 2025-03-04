class User {
  final int id;
  final String name;
  final String email;
  final String avatar;
  final String createdAt;
  final String username;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.createdAt,
    required this.username,
  });

  // JSON'den User modeline dönüştürme
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      createdAt: (json['createdAt'] as String),
      username: json['username'] as String,
    );
  }

  // User modelini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'createdAt': createdAt,
      'username': username,
    };
  }
}
