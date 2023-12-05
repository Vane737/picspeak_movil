class User {
  int? id;
  String? nickname;
  bool? status;
  int? contactId;

  User({this.id, this.nickname, this.status, this.contactId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nickname: json['nickname'],
      status: json['status'],
      contactId: json['contactId'],
    );
  }
}
