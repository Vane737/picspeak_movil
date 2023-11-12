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
    this.token
  });

  factory User.fromJson(Map<String, dynamic> json) {
      DateTime? birthDate = json['user']['birthDate'] != null ? DateTime.parse(json['user']['birthDate']) : null;

    print("ingresa a función: ${json['user']['name']} - ${json['user']['id']} - ${json['user']['username']} - $birthDate data- ${json['user']['gender']} - ${json['user']['nationality']} - ${json['user']['email']} - ${json['user']['password']} - ${json['token']} ${json['user']['photo_url']}");
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
      token: json['token']
    );
    
  }
}