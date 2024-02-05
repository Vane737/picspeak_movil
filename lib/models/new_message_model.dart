class NewMessage {
  final String? textOrigin;
  final String? textTranslate;
  final int? senderId;
  final String? imageUrl;
  final DateTime? messageTime;
  final bool? isShow;
  final String? audioOriginal;
  final String? audioTranslated;

  NewMessage(
      {this.textOrigin,
      this.textTranslate,
      this.senderId,
      this.imageUrl,
      this.messageTime,
      this.isShow,
      this.audioOriginal,
      this.audioTranslated});

  // Un método de fábrica para crear una instancia de ChatMessage desde un mapa
  factory NewMessage.fromJson(Map<dynamic, dynamic> json) {
    return NewMessage(
        textOrigin:
            (json['text'].isNotEmpty ? json['text'][0]['textOrigin'] : null),
        textTranslate:
            (json['text'].isNotEmpty ? json['text'][0]['textTranslate'] : null),
        senderId: json['individualUser']['id'],
        imageUrl: (json['image'].isNotEmpty ? json['image'][0]['url'] : null),
        messageTime: DateTime.parse(json['createdAt']),
        isShow: json['isShowing'],
        audioOriginal: (json['audio'].isNotEmpty
            ? json['audio'][0]['originalAudioUrl']
            : null),
        audioTranslated: (json['audio'].isNotEmpty
            ? json['audio'][0]['translatedAudioUrl']
            : null));
  }
}
