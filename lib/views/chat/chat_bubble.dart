// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:video_player/video_player.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isSender;
  final String time;
  final String? textTranslate;
  final String? imageMessage;
  final bool? isShow;
  final String? audioOriginal;
  final String? audioTranslated;
  final String? videoMessage;

  const ChatBubble(
      {Key? key,
      required this.message,
      required this.isSender,
      required this.time,
      this.textTranslate,
      this.imageMessage,
      this.isShow,
      this.audioOriginal,
      this.audioTranslated,
      this.videoMessage})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  late FlutterSoundPlayer _player;
  bool? isBlurEnabled;
  bool isPlaying = false;
  VideoPlayerController? _videoController;
  late Future<void> _initialzeVideoPlayer;

  @override
  void initState() {
    super.initState();
    isBlurEnabled = widget.isShow;
    _player = FlutterSoundPlayer();
    if (widget.videoMessage != null) {
      _videoController = VideoPlayerController.network(widget.videoMessage!);
      _initialzeVideoPlayer = _videoController!.initialize().then((_) {
        setState(() {});
      });
      _videoController?.setLooping(true);

      _videoController!.addListener(() {setState(() {});});
    }
  }

  @override
  void dispose() {
    _player.closePlayer();
    if (_videoController != null) {
      _videoController!.dispose();
    }

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
              } else if (widget.videoMessage != null) {
                _showVideoFullScreen(context, widget.videoMessage!);
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
                    if (widget.videoMessage != null)
                      _videoController != null &&
                              _videoController!.value.isInitialized
                          ? SizedBox(
                              height: 200,
                              child: VideoPlayer(_videoController!),
                            )
                          : const CircularProgressIndicator(),
                    if (widget.imageMessage == null &&
                        widget.videoMessage == null)
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
                        height: 6.0,
                      ),
                    if (widget.textTranslate != null)
                      Text(
                        widget.textTranslate!,
                        style: TextStyle(
                          color: widget.isSender ? Colors.white : Colors.black,
                        ),
                      ),
                    if (widget.audioOriginal != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                            ),
                            onPressed: () {
                              if (widget.isSender) {
                                _playPauseAudio(widget.audioOriginal!);
                              } else {
                                _playPauseAudio(widget.audioTranslated!);
                              }
                            },
                          ),
                          Text(
                            'Toca para reproducir',
                            style: TextStyle(
                              color:
                                  widget.isSender ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
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
              } else if (widget.videoMessage != null) {
                _showVideoFullScreen(context, widget.videoMessage!);
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
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.imageMessage != null) ...[
                      if (widget.isSender)
                        Image.network(
                          widget.imageMessage!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      if (!widget.isSender)
                        const Text(
                          'Imagen con contenido sensible',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      if (!widget.isSender)
                        const Text(
                          'Toque para mostrar',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                    ],
                    if (widget.videoMessage != null) ...[
                      if (widget.isSender)
                        SizedBox(
                          height: 200,
                          child: VideoPlayer(_videoController!),
                        ),
                      if (!widget.isSender)
                        const Text(
                          'Video con contenido sensible',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      if (!widget.isSender)
                        const Text(
                          'Toque para mostrar',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                    ]
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
            style: const TextStyle(fontSize: 11.0),
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
    try {
      if (isPlaying) {
        await _player.stopPlayer();
      } else {
        await _player.openPlayer();
        await _player.startPlayer(
          fromURI: audioUrl,
          codec: Codec.aacADTS,
          whenFinished: () {
            setState(() {
              isPlaying = false;
            });
          },
        );

        _player.setSubscriptionDuration(const Duration(milliseconds: 100));
      }
    } catch (e) {
      print('Error playing audio: $e');
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _showVideoFullScreen(BuildContext context, String videoUrl) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text(''),
                  ),
                  body: FutureBuilder(
                    future: _initialzeVideoPlayer,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                      child: Icon(_videoController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        setState(() {
                          if (_videoController!.value.isPlaying) {
                            _videoController!.pause();
                          } else {
                            _videoController!.play();
                          }
                        });
                      }),
                )));
  }
}
