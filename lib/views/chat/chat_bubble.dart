// ignore_for_file: use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isSender;
  final String time;
  final String? textTranslate; // Agrega el text_translate
  final String? imageMessage;
  final bool? isShow;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.isSender,
      required this.time,
      this.textTranslate,
      this.imageMessage,
      this.isShow});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool isBlurEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment:
              widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: widget.isSender
                  ? const Color.fromARGB(255, 77, 180, 245)
                  : const Color.fromARGB(255, 217, 217, 217),
              borderRadius: widget.isSender
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
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.imageMessage != null)
                  Stack(
                    children: [
                      Image.network(
                        widget.imageMessage!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      if (isBlurEnabled)
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            color: Colors.transparent,
                            width: 150,
                            height: 150,
                          ),
                        ),
                      Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          left: 0,
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                isBlurEnabled ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isBlurEnabled = !isBlurEnabled;
                                });
                              },
                            ),
                          )),
                    ],
                  ),
                if (widget.imageMessage == null)
                  Text(
                    widget.message,
                    style: TextStyle(
                      color: widget.isSender ? Colors.white : Colors.black,
                    ),
                  ),
                if (widget.textTranslate != null)
                  Divider(
                    color: widget.isSender ? Colors.white : Colors.black,
                    thickness: 1.0,
                    height: 8.0,
                  ),
                if (widget.textTranslate != null)
                  Text(
                    widget.textTranslate!,
                    style: TextStyle(
                      color: widget.isSender ? Colors.white : Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Align(
          alignment:
              widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            widget.time,
            style: const TextStyle(fontSize: 12.0),
          ),
        ),
      ],
    );
  }
}
