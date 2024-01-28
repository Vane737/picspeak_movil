// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isSender;
  final String time;
  final String? textTranslate;
  final String? imageMessage;
  final bool? isShow;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isSender,
    required this.time,
    this.textTranslate,
    this.imageMessage,
    this.isShow,
  }) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool? isBlurEnabled;

  @override
  void initState() {
    super.initState();
    isBlurEnabled = widget.isShow;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isBlurEnabled != false)
          InkWell(
            onTap: () {
              if (widget.imageMessage != null) {
                _showImageFullScreen(context, widget.imageMessage!);
              }
            },
            child: Align(
              alignment:
                  widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
                      Image.network(
                        widget.imageMessage!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    if (widget.imageMessage == null)
                      Text(
                        widget.message,
                        style: TextStyle(
                          color:
                              widget.isSender ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.textTranslate != null)
                      Divider(
                        color:
                            widget.isSender ? Colors.white : Colors.black,
                        thickness: 1.0,
                        height: 8.0,
                      ),
                    if (widget.textTranslate != null)
                      Text(
                        widget.textTranslate!,
                        style: TextStyle(
                          color:
                              widget.isSender ? Colors.white : Colors.black,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (isBlurEnabled == false)
          GestureDetector(
            onTap: () {
              if (widget.imageMessage != null) {
                _showImageFullScreen(context, widget.imageMessage!);
              }
            },
            child: Align(
              alignment: widget.isSender
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey, // Color para burbuja especial
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Imagen con contenido sensible',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Toque para mostrar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
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

  void _showImageFullScreen(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: Center(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
