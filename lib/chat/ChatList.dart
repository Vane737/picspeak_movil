import 'package:flutter/material.dart';

import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:picspeak_front/chat/Chat.dart';
import 'package:picspeak_front/chat/IndividualChat.dart';
import 'package:picspeak_front/chat/chatListItem.dart';

void main() => runApp(ChatList());

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatListScreen(),
    );
  }
}

class ChatListScreen extends StatelessWidget {
  final List<Chat> chatList = [
    Chat("Usuario 1", "Hola, ¿cómo estás?", "10:00 AM",
        'assets/imagenes/avatar1.png'),
    Chat("Usuario 2", "¡Hola! Estoy bien, ¿y tú?", "10:15 AM",
        'assets/imagenes/avatar2.png'),
    // Agrega más chats aquí...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 11, 121, 158),

        title: Text(
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
            color: Color.fromARGB(255, 11, 121, 158),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
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
                      // Lógica para abrir la pantalla de chat.
                    } else if (choice == 'Informacion') {
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
            color: Color.fromARGB(255, 11, 121, 158),
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
                          TextStyle(
                            fontSize: 16, // Cambia el tamaño de la letra
                            color: Color.fromARGB(255, 248, 248,
                                248), // Cambia el color del texto
                          ),
                        ),
                      ),
                      child: Text(
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
                          TextStyle(
                            fontSize: 16, // Cambia el tamaño de la letra
                            color: Color.fromARGB(255, 248, 248,
                                248), // Cambia el color del texto
                          ),
                        ),
                      ),
                      child: Text(
                        "Grupo",
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
                          TextStyle(
                            fontSize: 16, // Cambia el tamaño de la letra
                            color: Color.fromARGB(255, 255, 255,
                                255), // Cambia el color del texto
                          ),
                        ),
                      ),
                      child: Text(
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
          Expanded(
            child: ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                final chat = chatList[index];
                return ChatListItem(chat);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IndividualChatScreen extends StatefulWidget {
  final Chat chat;

  IndividualChatScreen(this.chat);

  @override
  IndividualChatScreenState createState() => IndividualChatScreenState();
}