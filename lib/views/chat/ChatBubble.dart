import 'package:flutter/material.dart';

import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time; // Agrega el tiempo

  ChatBubble(
      {required this.message, required this.isSender, required this.time});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isSender ? Color.fromARGB(255, 255, 215, 0) : Colors.grey,
              borderRadius: isSender
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time, // Muestra la hora debajo de la burbuja de chat
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}
