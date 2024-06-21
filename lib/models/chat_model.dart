
/* List<ChatListModel> ChatListModelFromJson(String str) => List<ChatListModel>.from(json.decode(str).map((x) => ChatListModel.fromJson(x)));

String ChatListModelToJson(List<ChatListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
 */
class ChatListModel {
    int chatId;
    int otherUserId;
    int? originalUserId;
    String? otherUserName;
    String? otherUserLastname;
    String? otherUserUsername;
    String? otherUserPhoto;
    String? otherUserNacionality;
    String? otherUserMaternLanguage;
    String? originalUserMaternLanguage;
    int? messageUserId;
    DateTime? messageDatetime;
    String? messageTextOrigin;
    String? messageTextTranslate;
    int? userId;

    ChatListModel({
        required this.chatId,
        required this.otherUserId,
        this.originalUserId,
        this.otherUserName,
        this.otherUserLastname,
        this.otherUserUsername,
        this.otherUserPhoto,
        this.otherUserNacionality,
        this.otherUserMaternLanguage,
        this.originalUserMaternLanguage,
        this.messageUserId,
        this.messageDatetime,
        this.messageTextOrigin,
        this.messageTextTranslate,
        this.userId,
    });

    factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        chatId: json["chat_id"],
        otherUserId: json["other_user_id"],
        originalUserId: json["original_user_id"],
        otherUserName: json["other_user_name"],
        otherUserLastname: json["other_user_lastname"],
        otherUserUsername: json["other_user_username"],
        otherUserPhoto: json["other_user_photo"],
        otherUserNacionality: json["other_user_nacionality"],
        otherUserMaternLanguage: json["other_user_matern_language"],
        originalUserMaternLanguage: json["original_user_matern_language"],
        messageUserId: json["message_user_id"],
        messageDatetime: json["message_datetime"] == null ? null : DateTime.parse(json["message_datetime"]),
        messageTextOrigin: json["message_text_origin"],
        messageTextTranslate: json["message_text_translate"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "other_user_id": otherUserId,
        "original_user_id": originalUserId,
        "other_user_name": otherUserName,
        "other_user_lastname": otherUserLastname,
        "other_user_username": otherUserUsername,
        "other_user_photo": otherUserPhoto,
        "other_user_nacionality": otherUserNacionality,
        "other_user_matern_language": otherUserMaternLanguage,
        "original_user_matern_language": originalUserMaternLanguage,
        "message_user_id": messageUserId,
        "message_datetime": messageDatetime?.toIso8601String(),
        "message_text_origin": messageTextOrigin,
        "message_text_translate": messageTextTranslate,
        "userId": userId,
    };
}
