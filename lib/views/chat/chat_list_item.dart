// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/views/chat/individual_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatListItem extends StatelessWidget {
  final ChatListModel chat;
  final io.Socket socket; 

  const ChatListItem(this.chat, this.socket);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30.0, 
            backgroundColor: Colors
                .blue, 
            child: ClipOval(
              child: Image.network(
                chat.otherUserPhoto!, 
                fit: BoxFit.cover,
                width: 2 *
                    30.0, 
                height: 2 *
                    30.0, 
              ),
            ),
          ),
        ],
      ),
      title: Row(
        children: [
          Text(
            getFlagEmoji(chat.otherUserMaternLanguage!),
            style: const TextStyle(
              fontSize: 22.0,
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            chat.otherUserUsername!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      subtitle: Text(chat.messageTextTranslate ?? ""),
      trailing: Text(
          formatDateTime(chat.messageDatetime.toString()),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => IndividualChatScreen(chat, socket),
        ));
      },
    );
  }
}

// Función para obtener el emoji de bandera según el idioma
String getFlagEmoji(String language) {
  switch (language.toLowerCase()) {
    case 'español':
      return '🇪🇸'; // Emoji de la bandera española
    case 'inglés':
      return '🇬🇧'; // Emoji de la bandera inglesa
    case 'alemán':
      return '🇩🇪'; // Emoji de la bandera alemana
    case 'italiano':
      return '🇮🇹'; // Emoji de la bandera italiana
    case 'portugués':
      return '🇧🇷'; // Emoji de la bandera brasileña
    case 'holandés':
      return '🇳🇱'; // Emoji de la bandera neerlandesa
    case 'ruso':
      return '🇷🇺'; // Emoji de la bandera rusa
    case 'chino':
      return '🇨🇳'; // Emoji de la bandera china
    case 'japonés':
      return '🇯🇵'; // Emoji de la bandera japonesa
    case 'coreano':
      return '🇰🇷'; // Emoji de la bandera coreana
    case 'árabe':
      return '🇸🇦'; // Emoji de la bandera árabe
    case 'hindi':
      return '🇮🇳'; // Emoji de la bandera hindi
    case 'bengalí':
      return '🇧🇩'; // Emoji de la bandera bengalí
    case 'turco':
      return '🇹🇷'; // Emoji de la bandera turca
    case 'hebreo':
      return '🇮🇱'; // Emoji de la bandera hebrea
    case 'sueco':
      return '🇸🇪'; // Emoji de la bandera sueca
    case 'noruego':
      return '🇳🇴'; // Emoji de la bandera noruega
    case 'danés':
      return '🇩🇰'; // Emoji de la bandera danesa
    case 'francés':
      return '🇫🇷';
    default:
      return ''; // Valor predeterminado si no se encuentra el idioma
  }
}

