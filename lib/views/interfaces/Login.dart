class Login {
  String message;
  Info user;

  Login({
    required this.message,
    required this.user,
  });

  // Constructor para crear una instancia de Login desde un mapa JSON
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      message: json['message'] ?? '',
      user: Info.fromJson(json['user'] ?? {}),
    );
  }
}

class Info {
  String token;
  String email;

  Info({
    required this.token,
    required this.email,
  });

  // Constructor para crear una instancia de Info desde un mapa JSON
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      token: json['token'] ?? '',
      email: json['email'] ?? '',
    );
  }
}