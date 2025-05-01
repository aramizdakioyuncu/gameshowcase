class User {
  final int id;
  final String token;
  final String name;
  String? email;
  final String avatar;
  String? createdAt;
  final String? role;
  final String username;

  User({
    required this.id,
    required this.token,
    required this.name,
    this.email,
    required this.avatar,
    this.createdAt,
    required this.role,
    required this.username,
  });

  // JSON'den User modeline dönüştürme
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      token: json['token'] as String,
      name: json['name'] as String,
      email: json['email'],
      avatar: json['avatar'] as String,
      createdAt: (json['createdAt']),
      role: json['role'] as String,
      username: json['username'] as String,
    );
  }

  // User modelini JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'email': email,
      'avatar': avatar,
      'createdAt': createdAt,
      'role': role,
      'username': username,
    };
  }
}
