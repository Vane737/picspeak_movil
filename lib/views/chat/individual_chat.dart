// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print, unused_field, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/models/message_model.dart';
import 'package:picspeak_front/models/new_message_model.dart';
import 'package:picspeak_front/services/auth_service.dart';
import 'package:picspeak_front/services/chat_service.dart';
import 'package:picspeak_front/views/user_information/view_profile_screen.dart';
import 'package:picspeak_front/services/configuration_service.dart';
import 'package:picspeak_front/services/notification_service.dart';
import 'package:picspeak_front/views/chat/chat_bubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';

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
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  File? _selectedVideo;
  late FlutterSoundPlayer _player;
  late FlutterSoundRecorder _recorder;

  bool _isRecording = false;
  String _recordedAudioPath = '';
  List<String> fastAnswers = [];

  void showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const EmojiPicker();
      },
    );
  }

  Future<void> _getMultimediaFromGallery() async {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const CircleAvatar(
                    backgroundColor: AppColors.bgYellow,
                    child: Icon(
                      Icons.image,
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.pop(context);
                  _selectImage();
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                    backgroundColor: AppColors.bgYellow,
                    child: Icon(
                      Icons.video_camera_front,
                      color: Colors.white,
                    )),
                onTap: () {
                  Navigator.pop(context);
                  _selectVideo();
                },
              )
            ],
          );
        });
  }

  Future<void> _selectImage() async {
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      _showSendImageDialog();
    } else {
      print('Selección de imagen cancelada.');
    }
  }

  Future<void> _selectVideo() async {
    final XFile? video =
        await _imagePicker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        _selectedVideo = File(video.path);
      });
      _showSendImageDialog();
    } else {
      print('Selección de imagen cancelada.');
    }
  }

  Future<void> _getAudioFromRecord() async {
    bool isRecording = _isRecording;

    if (isRecording) {
      String recordedAudioPath = await stopRecording();
      _showSendAudioDialog(recordedAudioPath);
    } else {
      var status = await Permission.microphone.status;

      if (status.isGranted) {
        await startRecording();
      } else {
        var result = await Permission.microphone.request();

        if (result.isGranted) {
          await startRecording();
        } else {
          print('Audio recording permission denied');
          return;
        }
      }
    }

    setState(() {
      _isRecording = !isRecording;
    });
  }

  Future<void> startRecording() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    _recordedAudioPath = '${appDocumentsDirectory.path}/recorded_audio.aac';

    await _recorder.openRecorder();
    await _recorder.startRecorder(
      toFile: _recordedAudioPath,
      codec: Codec.aacADTS,
    );
  }

  Future<String> stopRecording() async {
    await _recorder.stopRecorder();
    await _recorder.closeRecorder();
    return _recordedAudioPath;
  }

  void _showSendAudioDialog(String audioPath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.3,
              child: AlertDialog(
                title: const Text(''),
                content: const Column(
                  children: [
                    Text('¿Deseas enviar este audio?'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      sendAudio(audioPath);
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              )),
        );
      },
    );
  }

  void _showSendImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.5,
            child: AlertDialog(
              title: const Text(''),
              contentPadding: EdgeInsets.zero,
              content: Column(
                children: [
                  if (_selectedImage != null)
                    Expanded(
                      child: Image.file(
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 16),
                  const Text('¿Deseas enviar este archivo?'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    String? image = _selectedImage == null
                        ? null
                        : getStringImage(_selectedImage);
                    print('file $image');
                    if (_selectedImage != null) {
                      sendImage(image!);
                    }
                    String? video = _selectedVideo == null
                        ? null
                        : getStringImage(_selectedVideo);
                    if (_selectedVideo != null) {
                      sendVideo(video!);
                    }
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  initState() {
    super.initState();
    joinChat();
    setupSocketListeners();
    _player = FlutterSoundPlayer();
    _recorder = FlutterSoundRecorder();
  }

  @override
  void dispose() {
    widget.socket.off('messagesLoaded');
    super.dispose();
  }

  joinChat() {
    if (widget.socket.connected) {
      var joinChatData = {
        'chat': widget.chat.chatId.toString(),
        'senderUserId': userId, // Asegúrate de tener userId definido
        'receivingUserId': widget.chat.otherUserId,
        'fondo': 'tuFondo',
      };

      // Emitir el evento 'chatJoined' con los datos del evento
      widget.socket.emit('chatJoined', joinChatData);
    }
  }

  Future<void> sendMessage(String message) async {
    String languageOrigen = await getLanguageUserData();

    if (widget.socket.connected) {
      Map<String, Object> messageData;
      String? languageTranslate =
          await getLanguageReceiver(widget.chat.otherUserId);

      messageData = {
        'receivingUserId': widget.chat.otherUserId,
        'message': {
          'userId': userId,
          'chatId': widget.chat.chatId,
          'resources': [
            {
              'type': 'T',
              'textOrigin': message,
              'languageOrigin': languageOrigen,
              'languageTarget': languageTranslate
            }
          ]
        },
      };

      // Emitir el evento 'sendMessage' con los datos del mensaje
      widget.socket.emit('sendMessage', messageData);
    }
    _messageController.clear();
    if (fastAnswers.contains(message)) {
      setState(() {
        fastAnswers.clear();
      });
    }
  }

  Future<void> sendNotification(String message) async {
    if (widget.socket.connected) {
      Map<String, Object> messageData;
      String? languageTranslate =
          await getLanguageReceiver(widget.chat.otherUserId);
      // Datos del mensaje que quieres enviar
      messageData = {
        'receivingUserId': widget.chat.otherUserId,
        'message': {
          'userId': userId,
          'chatId': widget.chat.chatId,
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

  void sendImage(String image) {
    if (widget.socket.connected) {
      Map<String, Object> messageData;
      messageData = {
        'receivingUserId': widget.chat.otherUserId,
        'message': {
          'userId': userId,
          'chatId': widget.chat.chatId,
          'resources': [
            {
              'type': 'I',
              'pathDevice': image,
            }
          ]
        },
      };
      widget.socket.emit('sendMessage', messageData);

      setState(() {
        _selectedImage = null;
      });
    }
  }

  void sendVideo(String video) {
    if (widget.socket.connected) {
      Map<String, Object> messageData;
      messageData = {
        'receivingUserId': widget.chat.otherUserId,
        'message': {
          'userId': userId,
          'chatId': widget.chat.chatId,
          'resources': [
            {
              'type': 'V',
              'pathDevice': video,
            }
          ]
        },
      };
      print('MESSAGE VIDEO $messageData');
      widget.socket.emit('sendMessage', messageData);
    }
  }

  Future<void> sendAudio(String audioPath) async {
    String? languageTranslate =
        await getLanguageReceiver(widget.chat.otherUserId);
    String languageOrigen = await getLanguageUserData();

    if (widget.socket.connected) {
      try {
        List<int> audioBytes = await File(audioPath).readAsBytes();

        Map<String, Object> messageData;
        messageData = {
          'receivingUserId': widget.chat.otherUserId,
          'message': {
            'userId': userId,
            'chatId': widget.chat.chatId,
            'resources': [
              {
                "type": "A",
                "textOrigin": audioPath,
                "languageOrigin": languageOrigen,
                "languageTarget": languageTranslate,
              }
            ]
          },
          "audioFile": audioBytes
        };
        widget.socket.emit('sendMessage', messageData);
      } catch (e) {
        print('Error sending audio: $e');
      }
    }
  }

  void setupSocketListeners() {
    // Manejar los mensajes cargados al unirse al chat
    widget.socket.on('messagesLoaded', (data) async {
      print('Received data from server (messagesLoaded): $data');

      if (data is List) {
        List<ChatMessage> chatMessages =
            data.map((item) => ChatMessage.fromJson(item)).toList();

        if (mounted) {
          List<ChatBubble> newChatBubbles =
              await Future.wait(chatMessages.map((message) async {
            return ChatBubble(
              message: message.textOrigin ?? '',
              isSender: userId == message.individualUserId,
              time: formatDateTime(message.createdAt.toString()),
              textTranslate: message.textTranslate,
              imageMessage: message.url,
              isShow: message.isShow,
              audioOriginal: message.audioOriginal,
              audioTranslated: message.audioTranslated,
              videoMessage: message.videoUrl,
            );
          }));

          setState(() {
            chatBubbles.addAll(newChatBubbles);
          });

          ChatBubble? lastMessage = getLastMessage();
          if (lastMessage != null && !lastMessage.isSender) {
            await updateFastAnswer(lastMessage.message);
          }
        }
      } else {
        print('Invalid data format: $data');
      }
    });

    // Agrega este bloque para escuchar el evento newMessageNotification
    widget.socket.on('newMessageNotification', (data) {
      print('Received data from server (newMessageNotification): $data');
      if (data is Map<String, dynamic> && data['type'] == 'message') {
        String senderName = data['senderName'] ?? 'Unknown';
        String senderPhoto = data['senderPhoto'] ?? '';
        String message = data['message'] ?? '';

        NotificationService().showNotification(
          title: senderName,
          message: message,
        );
      } else {
        print('Invalid data format for newMessageNotification: $data');
      }
    });

    // Manejar el evento newMessage
    widget.socket.on('newMessage', (data) async {
      print('Received new message : $data');

      if (data is Map) {
        NewMessage newMessage = NewMessage.fromJson(data);

        bool isDuplicate = chatBubbles.any((bubble) =>
            bubble.message == newMessage.textOrigin &&
            bubble.isSender == (userId == newMessage.senderId));

        if (!isDuplicate) {
          if (mounted) {
            setState(() {
              chatBubbles.add(ChatBubble(
                  message: newMessage.textOrigin ?? '',
                  isSender: userId == newMessage.senderId,
                  time: formatDateTime(DateTime.now().toString()),
                  textTranslate: newMessage.textTranslate,
                  imageMessage: newMessage.imageUrl,
                  isShow: newMessage.isShow,
                  audioOriginal: newMessage.audioOriginal,
                  audioTranslated: newMessage.audioTranslated,
                  videoMessage: newMessage.videoMessage));
            });

            ChatBubble? lastMessage = getLastMessage();
            if (lastMessage != null && !lastMessage.isSender) {
              await updateFastAnswer(lastMessage.message);
            }
          }
        }
      } else {
        print('Invalid data format for newMessage: $data');
      }
    });
  }

  ChatBubble? getLastMessage() {
    if (chatBubbles.isEmpty) {
      return null;
    }

    return chatBubbles.last;
  }

  Future<void> updateFastAnswer(String message) async {
    try {
      List<String> answers = await getFastAnswers(message);
      List<String> filteredAnswers =
          answers.where((answer) => answer.isNotEmpty).toList();

      setState(() {
        fastAnswers = filteredAnswers;
      });
    } catch (e) {
      print('Error updating fast answers: $e');
    }
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
              child: GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewProfileScreen(id: widget.chat.otherUserId)),
                  );
                },
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.blue,
                  child: ClipOval(
                    child: Image.network(
                      widget.chat.otherUserPhoto!,
                      fit: BoxFit.cover,
                      width: 2 * 30.0,
                      height: 2 * 30.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(widget.chat.otherUserUsername!),
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
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Column(
      children: [
        if (fastAnswers.isNotEmpty)
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: fastAnswers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    sendMessage(fastAnswers[index]);
                  },
                  child: Chip(
                    label: Text(fastAnswers[index]),
                  ),
                );
              },
            ),
          ),
        const Divider(height: 2.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: _getMultimediaFromGallery,
              ),
              IconButton(
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                    ),
                    if (_isRecording)
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  _getAudioFromRecord();
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
                  if (message.isNotEmpty) {
                    sendMessage(message);
                    //_messageController.clear();
                  }
                },
              ),
            ],
          ),
        ),
        //_buildFastMessageSuggestions(),
      ],
    );
  }
}
