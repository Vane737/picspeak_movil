import 'package:flutter/material.dart';
import 'package:picspeak_front/views/chat/chat_bubble.dart';

class Contact {
  final int id;
  final String nickname;
  final String imageAsset;
  final int contactId;

  Contact(this.id, this.nickname, this.imageAsset, this.contactId);
}
