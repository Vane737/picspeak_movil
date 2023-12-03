import 'package:flutter/material.dart';

import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:picspeak_front/views/chat/Chat.dart';
import 'package:picspeak_front/views/chat/Contact.dart';
import 'package:picspeak_front/views/chat/ContactListItem.dart';
import 'package:picspeak_front/views/chat/FriendSuggestion.dart';
import 'package:picspeak_front/views/chat/FriendSuggestionItem.dart';
import 'package:picspeak_front/views/chat/IndividualChat.dart';
import 'package:picspeak_front/views/chat/chatListItem.dart';

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

  final List<Contact> contactList = [
    Contact("Contacto 1", 'assets/imagenes/avatar1.png'),
    Contact("Contacto 2", 'assets/imagenes/avatar2.png')
  ];

  final List<FriendSuggestion> friendSuggestions = [
    FriendSuggestion("Amigo Sugerido 1", 'assets/imagenes/avatar2.png'),
    FriendSuggestion("Amigo Sugerido 2", 'assets/imagenes/avatar2.png'),
    // Agrega más sugerencias de amigos aquí...
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                      return [
                        'Perfil',
                        'Informacion',
                        'Ajustes',
                        'Cerrar Sesion'
                      ].map((String choice) {
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
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Tab(
                  child: Text(
                'Contactos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Vista de Chat
            Column(
              children: [
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
            // Vista de Amigos
            Column(
              children: [
                // Lista de contactos
                Expanded(
                  child: ListView.builder(
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      final contact = contactList[index];
                      return ContactListItem(contact);
                    },
                  ),
                ),
                // Lista de sugerencias de amigos
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sugerencias",
                          style: TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Add some spacing between the title and the ListView
                      Expanded(
                        child: ListView.builder(
                          itemCount: friendSuggestions.length,
                          itemBuilder: (context, index) {
                            final friend = friendSuggestions[index];
                            return FriendSuggestionItem(friend);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
