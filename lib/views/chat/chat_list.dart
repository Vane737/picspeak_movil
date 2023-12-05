// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/views/chat/chat_list_item.dart';
import 'dart:convert';
import 'package:picspeak_front/presentation/screens/user_information/edit_profile_screen.dart';
import 'package:picspeak_front/presentation/screens/user_information/view_profile_screen.dart';
import 'package:picspeak_front/views/chat/individual_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

void main() => runApp(ChatList());

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatListScreen extends StatefulWidget {
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late io.Socket socket;
  bool isConnected = false;

  Future<List<Map<String, dynamic>>> fetchChatData() async {
    final urlChat = '{$chatsByUserUrl$userId}';
    print(urlChat);
    final response = await http.get(Uri.parse('$chatsByUserUrl$userId'));
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load chat data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChatData();
    initSocket();
  }

  initSocket() {
    socket = io.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userId': userId},
    });
    socket.connect();

    socket.on('connect', (_) {
      setState(() {
        isConnected = true;
      });
      print('Conectado al socket $userId');
    });

    socket.on('disconnect', (_) {
      setState(() {
        isConnected = false;
      });
      print('Desconectado del socket');
    });
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 11, 121, 158),
        title: const Text(
          '¡PickSpeak!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ), // Título principal
        actions: [
          Container(
            // Este es el "segundo AppBar" que emulamos en el ejemplo anterior.
            height: 50,
            color: const Color.fromARGB(255, 11, 121, 158),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                  onPressed: () {
                    // Agregar aquí la lógica para la búsqueda.
                  },
                ),
                PopupMenuButton<String>(
                  onSelected: (choice) {
                    // Manejar las opciones del menú.
                    if (choice == 'Perfil') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                      // Lógica para abrir la pantalla de chat.
                    } else if (choice == 'Informacion') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewProfileScreen(),
                        ),
                      );
                      // Lógica para abrir la pantalla de grupos.
                    } else if (choice == 'Ajustes') {
                      // Lógica par
                      //a abrir la pantalla de amigos.
                    } else if (choice == 'Cerrar Sesion') {
                      // Lógica par
                      //a abrir la pantalla de amigos.
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return ['Perfil', 'Informacion', 'Ajustes', 'Cerrar Sesion']
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            color: const Color.fromARGB(255, 11, 121, 158),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Alineación de los botones
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Lógica para abrir la pantalla de chats.
                      },
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                            fontSize: 16, // Cambia el tamaño de la letra
                            color: Color.fromARGB(255, 248, 248,
                                248), // Cambia el color del texto
                          ),
                        ),
                      ),
                      child: const Text(
                        "Chat",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        // Lógica para abrir la pantalla de chats.
                      },
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(
                            fontSize: 16, // Cambia el tamaño de la letra
                            color: Color.fromARGB(255, 255, 255,
                                255), // Cambia el color del texto
                          ),
                        ),
                      ),
                      child: const Text(
                        "Amigos",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchChatData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final List<Map<String, dynamic>> chatData = snapshot.data!;
                  print(chatData); // Add this line to print the data
                  return Expanded(
                    child: ListView.builder(
                      itemCount: chatData.length,
                      itemBuilder: (context, index) {
                        final chatMap = chatData[index];
                        final chat = ChatListModel(
                          id: chatMap['chatid'],
                          receivingUserId: chatMap['resuserid'],
                          receivingUsername: chatMap['resusername'],
                          receivingUserPhoto: chatMap['resuserphoto'],
                          receivingUserNation: chatMap['resusernation'],
                          message: chatMap['message'],
                          timeMessage: chatMap['hora'] != null
                              ? DateTime.parse(chatMap['hora'])
                              : null,
                        );
                        return ChatListItem(chat);
                      },
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}

class IndividualChatScreen extends StatefulWidget {
  final ChatListModel chat;

  const IndividualChatScreen(this.chat);

  @override
  IndividualChatScreenState createState() => IndividualChatScreenState();
}
