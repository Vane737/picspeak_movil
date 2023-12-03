import 'package:flutter/material.dart';
import 'package:picspeak_front/views/chat/ChatBubbleReply.dart';
import 'package:picspeak_front/views/chat/ChatList.dart';
import 'package:picspeak_front/views/chat/chatBubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class IndividualChatScreenState extends State<IndividualChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Widget> chatBubbles = [];

  void sendReply(String message) {
    setState(() {
      chatBubbles.add(ChatBubbleReply(message: message));
    });
  }

  void showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return EmojiPicker();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 121, 158),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: CircleAvatar(
                radius: 20.0,
                child: Image.asset(
                  widget.chat
                      .imageAsset, // Accede a la ruta de la imagen de perfil
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text(widget.chat.senderName),
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
                        icon: Icon(
                            Icons.camera_alt), // Icono para abrir la cámara
                        onPressed: () {
                          // Lógica para abrir la cámara y enviar una imagen
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.emoji_emotions), // Icono para emojis
                        onPressed: () {
                          showEmojiPicker(context);
                        },
                      ),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Escribe un mensaje...',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          String message = _messageController.text;
                          if (message.isNotEmpty) {
                            sendReply(message);

                            setState(() {
                              chatBubbles.add(
                                ChatBubble(
                                  message: message,
                                  isSender: true,
                                  time: '10:00',
                                ),
                              );

                              _messageController.clear();
                            });
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
