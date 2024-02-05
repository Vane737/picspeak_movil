// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isSender;
  final String time;
  final String? textTranslate;
  final String? imageMessage;
  final bool? isShow;
  final String? audioOriginal;
  final String? audioTranslated;

  const ChatBubble(
      {Key? key,
      required this.message,
      required this.isSender,
      required this.time,
      this.textTranslate,
      this.imageMessage,
      this.isShow,
      this.audioOriginal,
      this.audioTranslated})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  late FlutterSoundPlayer _player;
  bool? isBlurEnabled;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    isBlurEnabled = widget.isShow;
    _player = FlutterSoundPlayer();
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
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
              alignment: widget.isSender
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
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
          ),
        if (isBlurEnabled == false)
          GestureDetector(
            onTap: () {
              if (widget.imageMessage != null) {
                _showImageFullScreen(context, widget.imageMessage!);
              } else if (widget.audioOriginal != null) {
                _playPauseAudio(widget.audioOriginal!);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.audioOriginal != null)
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            onPressed: () {
                              _playPauseAudio(widget.audioOriginal!);
                            },
                          ),
                          Text(
                            'Audio Message',
                            style: TextStyle(
                              color:
                                  widget.isSender ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    if (widget.imageMessage != null)
                      const Text(
                        'Imagen con contenido sensible',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    const Text(
                      'Toque para mostrar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                    _buildAudioIcon(),
                    _buildAudioInfo(),
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

  Future<void> _playPauseAudio(String audioUrl) async {
    print('ADUIO URL $audioUrl');
    try {
      if (isPlaying) {
        await _player.stopPlayer();
      } else {
        await _player.startPlayer(
          fromURI: audioUrl,
          codec: Codec.aacADTS,
        );
      }
    } catch (e) {
      print('Error playing audio: $e');
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  Widget _buildAudioIcon() {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      child: Icon(
        Icons.audiotrack,
        color: widget.isSender ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildAudioInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Audio Message',
            style: TextStyle(
              color: widget.isSender ? Colors.white : Colors.black,
            ),
          ),
          Text(
            'Duration:', //${_player.getProgress()?.toString()}',
            style: TextStyle(
              color: widget.isSender ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
