// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/models/message_model.dart';
import 'package:picspeak_front/views/chat/chat_bubble_reply.dart';
import 'package:picspeak_front/views/chat/chat_bubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class IndividualChatScreen extends StatefulWidget {
  final ChatListModel chat;
  final io.Socket socket;

  const IndividualChatScreen(this.chat, this.socket);

  @override
  IndividualChatScreenState createState() => IndividualChatScreenState();
}

class IndividualChatScreenState extends State<IndividualChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<ChatBubble> chatBubbles = [];

  void showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const EmojiPicker();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    joinChat();
    setupSocketListeners();
  }

  // Método para unirse al chat
  void joinChat() {
    if (widget.socket.connected) {
      var joinChatData = {
        'chat': widget.chat.id.toString(),
        'senderUserId': userId,
        'receivingUserId': widget.chat.receivingUserId,
        'fondo': 'tuFondo',
      };

      print('JOIN DATA $joinChatData');

      // Emitir el evento 'chatJoined' con los datos del evento
      widget.socket.emit('chatJoined', joinChatData);
    }
  }

  void sendMessage(String message) {
    if (widget.socket.connected) {
      //language to translate
      String? languageTranslate = userId == widget.chat.receivingUserId
          ? widget.chat.senderMotherLanguage
          : widget.chat.receiverMotherLanguage;
      // Datos del mensaje que quieres enviar
      var messageData = {
        'receivingUserId': widget.chat.receivingUserId,
        'message': {
          'userId': userId,
          'chatId': widget.chat.id,
          'resources': [
            {
              'type': 'T',
              'textOrigin': message,
              'languageTarget': languageTranslate
            }
          ]
        },
      };

      print('MESSAGE $messageData');

      // Emitir el evento 'sendMessage' con los datos del mensaje
      widget.socket.emit('sendMessage', messageData);
    }
  }

  void setupSocketListeners() {
    // Manejar los mensajes cargados al unirse al chat
    widget.socket.on('messagesLoaded', (data) {
      print('Received data from server (messagesLoaded): $data');

      if (data is List) {
        List<ChatMessage> chatMessages =
            data.map((item) => ChatMessage.fromJson(item)).toList();

        setState(() {
          chatBubbles.addAll(chatMessages.map(
            (message) => ChatBubble(
              message: message.textOrigin ?? '',
              isSender: userId == message.individualUserId,
              time: '${message.createdAt!.hour}:${message.createdAt!.minute}',
              textTranslate: message.textTranslate,
            ),
          ));
        });
      } else {
        print('Invalid data format: $data');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 121, 158),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: CircleAvatar(
                radius: 20.0,
                child: Image.network(
                  widget.chat.receivingUserPhoto!, 
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(widget.chat.receivingUsername!),
          ],
        ),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatBubbles.length,
              itemBuilder: (context, index) {
                return chatBubbles[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                            Icons.camera_alt), // Icono para abrir la cámara
                        onPressed: () {
                          // Lógica para abrir la cámara y enviar una imagen
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                            Icons.emoji_emotions), // Icono para emojis
                        onPressed: () {
                          showEmojiPicker(context);
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Escribe un mensaje...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          String message = _messageController.text;
                          print('printMessage $_messageController.text');
                          if (message.isNotEmpty) {
                            sendMessage(message);
                            setupSocketListeners();
                            _messageController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
