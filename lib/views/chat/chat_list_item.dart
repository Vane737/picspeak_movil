// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/views/chat/individual_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatListItem extends StatelessWidget {
  final ChatListModel chat;
  final io.Socket socket; // Agrega la instancia del socket como un parámetro

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
            radius: 30.0, // Define el radio del círculo
            backgroundColor: Colors
                .blue, // Puedes cambiar el color de fondo según tus necesidades
            child: ClipOval(
              child: Image.network(
                chat.otherUserPhoto!, // Utiliza la ruta de la imagen del chat actual
                fit: BoxFit.cover,
                width: 2 *
                    30.0, // Asegura que la imagen tenga el doble del radio como ancho
                height: 2 *
                    30.0, // Asegura que la imagen tenga el doble del radio como altura
              ),
            ),
          ),
          /* Positioned(
            top: 38,
            bottom: 0,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 95, 228, 99),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: const Text(
                "En línea",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                ),
              ),
            ),
          ), */
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
      subtitle: Text(chat.messageTextTranslate!),
      trailing: Text(
          formatDateTime(chat.messageDatetime.toString()),
          //'${chat.messageDatetime!.hour.toString()}:${chat.messageDatetime!.minute.toString()}'
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
      return '🇵🇹'; // Emoji de la bandera portuguesa
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
    // Puedes agregar más casos según tus necesidades
    default:
      return ''; // Valor predeterminado si no se encuentra el idioma
  }
}

