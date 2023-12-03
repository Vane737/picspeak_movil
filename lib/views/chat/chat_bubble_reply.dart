// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChatBubbleReply extends StatelessWidget {
  final String message;

  const ChatBubbleReply({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // Alinea la burbuja a la izquierda
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
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
          style: const TextStyle(
              color: Color.fromARGB(
                  255, 252, 250, 250)), // Color de texto diferente
        ),
      ),
    );
  }
}
