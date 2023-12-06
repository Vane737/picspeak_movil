class ChatListModel {
  int id;
  int receivingUserId;
  String? receivingUsername;
  String? receivingUserPhoto;
  String? receivingUserNation;
  String? message;
  DateTime? timeMessage;
  String? senderMotherLanguage;
  String? receiverMotherLanguage;

  ChatListModel(
      {required this.id,
      required this.receivingUserId,
      this.receivingUsername,
      this.receivingUserPhoto,
      this.receivingUserNation,
      this.message,
      this.timeMessage,
      this.senderMotherLanguage,
      this.receiverMotherLanguage});

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
      id: json['chatid'],
      receivingUserId: json['resuserid'],
      receivingUsername: json['resusername'],
      receivingUserPhoto: json['resuserphoto'],
      receivingUserNation: json['resusernation'],
      message: json['message'],
      senderMotherLanguage: json['sendermotherlanguage'],
      receiverMotherLanguage: json['receivermotherlanguage'],
      timeMessage: json['hora'] != null
          ? DateTime.tryParse(
              json['hora'] ?? '') // Use tryParse to handle null or invalid date
          : null,
    );
  }
}
