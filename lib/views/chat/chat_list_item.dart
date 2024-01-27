// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/presentation/screens/user_information/view_profile_screen.dart';
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
          Positioned(
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
          ),
        ],
      ),
      title: Row(
        children: [
          const Text(
            "🇺🇸",
            style: TextStyle(
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
          '${chat.messageDatetime!.hour.toString()}:${chat.messageDatetime!.minute.toString()}'),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => IndividualChatScreen(chat, socket),
        ));
      },
    );
  }
}
