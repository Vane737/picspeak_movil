import 'package:flutter/material.dart';
import 'package:picspeak_front/views/chat/chat_bubble.dart';

class Chat {
  final String senderName;
  final String lastMessage;
  final String time;
  final String imageAsset; // Ruta de la imagen para el chat

  Chat(this.senderName, this.lastMessage, this.time, this.imageAsset);
}
