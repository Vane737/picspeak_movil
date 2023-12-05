class ChatListModel {
  int id;
  int receivingUserId;
  String? receivingUsername;
  String? receivingUserPhoto;
  String? receivingUserNation;
  String? message;
  DateTime? timeMessage;

  ChatListModel(
      {required this.id,
      required this.receivingUserId,
      this.receivingUsername,
      this.receivingUserPhoto,
      this.receivingUserNation,
      this.message,
      this.timeMessage});

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      id: json['chatid'],
      receivingUserId: json['resuserid'],
      receivingUsername: json['resusername'],
      receivingUserPhoto: json['resuserphoto'],
      receivingUserNation: json['resusernation'],
      message: json['message'],
      timeMessage: json['hora'] != null
          ? DateTime.tryParse(
              json['hora'] ?? '') // Use tryParse to handle null or invalid date
          : null,
    );
  }
}
