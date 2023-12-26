class User {
  int? id;
  String? photourl;
  String? name;
  String? lastname;
  String? username;
  DateTime? birthDate;
  String? gender;
  String? nationality;
  String? email;
  String? password;
  String? token;
  String? activationToken;

  User({
    this.id, 
    this.photourl,
    this.name, 
    this.lastname,
    this.username,
    this.birthDate,
    this.gender,
    this.nationality,
    this.email, 
    this.password,
    this.token,
    this.activationToken
  });

  factory User.fromJson(Map<String, dynamic> json) {
    DateTime? birthDate = json['user']['birthDate'] != null
        ? DateTime.parse(json['user']['birthDate'])
        : null;

    return User(
        id: json['user']['id'],
        photourl: json['user']['photo_url'],
        name: json['user']['name'],
        lastname: json['user']['lastname'],
        username: json['user']['username'],
        birthDate: birthDate,
        gender: json['user']['gender'],
        nationality: json['user']['nationality'],
        email: json['user']['email'],
        password: json['user']['password'],
        activationToken: json['user']['activationToken'],
        token: json['token'],
      );        
  }
}
