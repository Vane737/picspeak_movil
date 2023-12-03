// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:picspeak_front/models/chat.dart';
import 'package:picspeak_front/views/chat/chat_list.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  const ChatListItem(this.chat);

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
            child: Image.asset(
              chat.imageAsset, // Utiliza la ruta de la imagen del chat actual
              width: 60.0,
              height: 60.0,
              fit: BoxFit.cover,
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
            chat.senderName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      subtitle: Text(chat.lastMessage),
      trailing: Text(chat.time),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => IndividualChatScreen(chat),
        ));
      },
    );
  }
}
