import 'package:picspeak_front/models/chat_model.dart';

class ContactModel {
  final int id;
  final String nickname;
  final String imageAsset;
  final int contactId;
  final ChatListModel chat;
  

  ContactModel(this.id, this.nickname, this.imageAsset, this.contactId, this.chat);
}