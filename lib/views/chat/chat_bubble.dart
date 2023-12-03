// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time; // Agrega el tiempo

  const ChatBubble(
      {required this.message, required this.isSender, required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isSender ? const Color.fromARGB(255, 255, 215, 0) : Colors.grey,
              borderRadius: isSender
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0),
                    ),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time, // Muestra la hora debajo de la burbuja de chat
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}
