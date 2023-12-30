class ChatListModel {
  int chatId;
  int originalUserId;
  String? originalUserMaternLanguage;
  int otherUserId;
  String? otherUserName;
  String? otherUserLastname;
  String? otherUserUsername;
  String? otherUserPhoto;
  String? otherUserNacionality;
  // String? otherUserNacionalityUrl;
  String? otherUserMaternLanguage;
  int? messageUserId;
  DateTime? messageDatetime;
  String? messageTextOrigin;
  String? messageTextTranslate;

  ChatListModel(
      {required this.chatId,
      required this.originalUserId,
      this.originalUserMaternLanguage,
      required this.otherUserId,
      this.otherUserName,
      this.otherUserLastname,
      this.otherUserUsername,
      this.otherUserPhoto,
      this.otherUserNacionality,
      // this.otherUserNacionalityUrl,
      this.otherUserMaternLanguage,
      this.messageUserId,
      this.messageDatetime,
      this.messageTextOrigin,
      this.messageTextTranslate});

  factory ChatListModel.fromJson(Map<String, dynamic> json) {
    return ChatListModel(
        chatId: json['chat_id'],
        originalUserId: json['original_user_id'],
            originalUserMaternLanguage: json['original_user_matern_language'],
        otherUserId: json['other_user_id'],
        otherUserName: json['other_user_name'],
        otherUserLastname: json['other_user_lastname'],
        otherUserUsername: json['other_user_username'],
        otherUserPhoto: json['other_user_photo'],
        otherUserNacionality: json['other_user_nacionality'],
        // otherUserNacionalityUrl: json['other_user_nacionality_url'],
        otherUserMaternLanguage: json['other_user_matern_language'],
        messageUserId: json['message_user_id'],
        messageDatetime: json['message_datetime'] != null
            ? DateTime.tryParse(json['message_datetime'] ??
                '') // Use tryParse to handle null or invalid date
            : null,
        messageTextOrigin: json['message_text_origin'],
        messageTextTranslate: json['message_text_translate']);
  }
}
