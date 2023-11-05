import 'package:flutter_chat_bubble/bubble_type.dart';

import 'package:flutter/material.dart';

class ChatBubbleReply extends StatelessWidget {
  final String message;

  ChatBubbleReply({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // Alinea la burbuja a la izquierda
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey, // Color diferente para respuestas
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomRight:
                Radius.circular(12.0), // Alinea la esquina inferior derecha
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
              color: const Color.fromARGB(
                  255, 252, 250, 250)), // Color de texto diferente
        ),
      ),
    );
  }
}
