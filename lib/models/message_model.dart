class ChatMessage {
  final int? id;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? individualUserId;
  final int? chatId;
  final String? type;
  final String? textOrigin;
  final String? textTranslate;
  final int? messageId;
  final String? url;
  final String? pathDevice;
  final dynamic content;
  final bool? isShow;
  final String? audioOriginal;
  final String? audioTranslated;

  ChatMessage({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.individualUserId,
    this.chatId,
    this.type,
    this.textOrigin,
    this.textTranslate,
    this.messageId,
    this.url,
    this.pathDevice,
    this.content,
    this.isShow,
    this.audioOriginal,
    this.audioTranslated
  });

  // Un método de fábrica para crear una instancia de ChatMessage desde un mapa
  factory ChatMessage.fromJson(Map<dynamic, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      individualUserId: json['individualUserId'],
      chatId: json['chatId'],
      type: json['type'],
      textOrigin: json['text_origin'],
      textTranslate: json['text_translate'],
      messageId: json['messageId'],
      url: json['url'],
      pathDevice: json['path_device'],
      content: json['content'],
      isShow: json['is_showing'],
      audioOriginal: json['original_audio_url'],
      audioTranslated: json['translated_audio_url']
    );
  }
}
