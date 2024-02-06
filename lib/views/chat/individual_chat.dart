// ignore_for_file: file_names, use_key_in_widget_constructors, avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/models/message_model.dart';
import 'package:picspeak_front/models/new_message_model.dart';
import 'package:picspeak_front/services/auth_service.dart';
import 'package:picspeak_front/presentation/screens/user_information/view_profile_screen.dart';
import 'package:picspeak_front/services/configuration_service.dart';
import 'package:picspeak_front/services/notification_service.dart';
import 'package:picspeak_front/views/chat/chat_bubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;

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
  late FlutterSoundPlayer _player;
  late FlutterSoundRecorder _recorder;

  bool _isRecording = false;
  String _recordedAudioPath = '';

  void showEmojiPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const EmojiPicker();
      },
    );
  }

  Future<void> _getImageFromGallery() async {
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

  Future<void> _getAudioFromRecord() async {
    bool isRecording = _isRecording;
    print('ISRECORDING $_isRecording');

    if (isRecording) {
      // Stop recording
      String recordedAudioPath = await stopRecording();
      _showSendAudioDialog(recordedAudioPath);
    } else {
      // Check audio recording permission
      var status = await Permission.microphone.status;

      if (status.isGranted) {
        // Start recording
        await startRecording();
      } else {
        // Request audio recording permission
        var result = await Permission.microphone.request();

        if (result.isGranted) {
          // Start recording after permission is granted
          await startRecording();
        } else {
          print('Audio recording permission denied');
          return;
        }
      }
    }

    setState(() {
      _isRecording = !isRecording;
      print('ISRECORDING STATE $_isRecording');
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
                      print('Enviar audio: $audioPath');
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
                  Expanded(
                    child: Image.file(
                      File(_selectedImage!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('¿Deseas enviar esta imagen?'),
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
                    print('Enviar imagen: ${_selectedImage!.path}');
                    if (_selectedImage != null) {
                      String? image = _selectedImage == null
                          ? null
                          : getStringImage(_selectedImage);
                      print('Enviar la imagen');
                      sendImage(image!);
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

  // Método para unirse al chat
  joinChat() {
    if (widget.socket.connected) {
      var joinChatData = {
        'chat': widget.chat.chatId.toString(),
        'senderUserId': userId, // Asegúrate de tener userId definido
        'receivingUserId': widget.chat.otherUserId,
        'fondo': 'tuFondo',
      };

      print('JOIN DATA $joinChatData');

      // Emitir el evento 'chatJoined' con los datos del evento
      widget.socket.emit('chatJoined', joinChatData);
    }
  }

  Future<void> sendMessage(String message) async {
    String languageOrigen = await getLanguageUserData();
    print('LANGUAGE $languageOrigen');

    if (widget.socket.connected) {
      Map<String, Object> messageData;
      //language to translate
      String? languageTranslate = userId == widget.chat.otherUserId
          ? widget.chat.originalUserMaternLanguage
          : widget.chat.otherUserMaternLanguage;
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
              'languageOrigin': languageOrigen,
              'languageTarget': languageTranslate
            }
          ]
        },
      };

      print('MESSAGE $messageData');

      // Emitir el evento 'sendMessage' con los datos del mensaje
      widget.socket.emit('sendMessage', messageData);
      // Enviar notificacion
    }
  }

  void sendNotification(String message) {
    if (widget.socket.connected) {
      Map<String, Object> messageData;
      //language to translate
      String? languageTranslate = userId == widget.chat.otherUserId
          ? widget.chat.originalUserMaternLanguage
          : widget.chat.otherUserMaternLanguage;
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
      print('IMAGE SEND: $image');
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
      print('MESSAGE IMAGE $messageData');
      // Emitir el evento 'sendMessage' con los datos del mensaje
      widget.socket.emit('sendMessage', messageData);
    }
  }

  Future<void> sendAudio(String audioPath) async {
    String? languageTranslate = userId == widget.chat.otherUserId
        ? widget.chat.originalUserMaternLanguage
        : widget.chat.otherUserMaternLanguage;

    String languageOrigen = await getLanguageUserData();
    print('LANGUAGE $languageOrigen');

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

        print('MESSAGE AUDIO $messageData');
        // Emit the 'sendMessage' event with the audio message data
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
            print(
                'AUDIO URL ${message.audioOriginal} ${message.audioTranslated}');
            return ChatBubble(
              message: message.textOrigin ?? '',
              isSender: userId == message.individualUserId,
              time: formatDateTime(message.createdAt.toString()),
              //time: '${message.createdAt!.hour}:${message.createdAt!.minute}',
              textTranslate: message.textTranslate,
              imageMessage: message.url,
              isShow: message.isShow,
              audioOriginal: message.audioOriginal,
              audioTranslated: message.audioTranslated,
            );
          }));

          setState(() {
            chatBubbles.addAll(newChatBubbles);
          });
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

        // Muestra la notificación utilizando el servicio de notificación
        NotificationService().showNotification(
          title: senderName,
          message: message,
          // Aqui podria ir el onSelectNotification
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
        print('New Message ${newMessage.audioOriginal}');

        if (mounted) {
          setState(() {
            // Agregar un nuevo ChatBubble para el nuevo mensaje
            chatBubbles.add(ChatBubble(
                message: newMessage.textOrigin ?? '',
                isSender: userId == newMessage.senderId,
                time: formatDateTime(DateTime.now().toString()),
                textTranslate: newMessage.textTranslate,
                imageMessage: newMessage.imageUrl,
                isShow: newMessage.isShow,
                audioOriginal: newMessage.audioOriginal,
                audioTranslated: newMessage.audioTranslated));
          });
        }
      } else {
        print('Invalid data format for newMessage: $data');
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
                  radius: 20.0, // Define el radio del círculo
                  backgroundColor: Colors
                      .blue, // Puedes cambiar el color de fondo según tus necesidades
                  child: ClipOval(
                    child: Image.network(
                      widget.chat
                          .otherUserPhoto!, // Utiliza la ruta de la imagen del chat actual
                      fit: BoxFit.cover,
                      width: 2 *
                          30.0, // Asegura que la imagen tenga el doble del radio como ancho
                      height: 2 *
                          30.0, // Asegura que la imagen tenga el doble del radio como altura
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: _getImageFromGallery,
                      ),
                      /* IconButton(
                        icon: const Icon(Icons.emoji_emotions),
                        onPressed: () {
                          showEmojiPicker(context);
                        },
                      ), */
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
                          print('IS RECORDING $_isRecording');
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
                          print('printMessage $_messageController.text');
                          if (message.isNotEmpty) {
                            sendMessage(message);
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
