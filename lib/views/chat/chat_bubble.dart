// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time;
  final String? textTranslate; // Agrega el text_translate

  const ChatBubble({
    required this.message,
    required this.isSender,
    required this.time,
    this.textTranslate,
  });

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
              color: isSender
                  ? const Color.fromARGB(255, 255, 215, 0)
                  : Colors.grey,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
                if (textTranslate != null)
                  Divider(
                    color: isSender ? Colors.white : Colors.black,
                    thickness: 1.0,
                    height: 8.0,
                  ),
                if (textTranslate != null)
                  Text(
                    textTranslate!,
                    style: const TextStyle(color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
        Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time,
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}
