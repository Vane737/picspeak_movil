import 'package:flutter/material.dart';
import 'package:picspeak_front/chat/Chat.dart';
import 'package:picspeak_front/chat/ChatList.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  ChatListItem(this.chat);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
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
                color: Color.fromARGB(255, 95, 228, 99),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
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
          Text(
            "🇺🇸",
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            chat.senderName,
            style: TextStyle(
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
