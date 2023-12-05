// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/models/chat.dart';
import 'package:picspeak_front/models/user.dart';
// import 'package:picspeak_front/views/chat/Chat.dart';
import 'package:picspeak_front/views/chat/Contact.dart';
import 'package:picspeak_front/views/chat/ContactListItem.dart';
import 'package:picspeak_front/views/chat/FriendSuggestion.dart';
import 'package:picspeak_front/views/chat/FriendSuggestionItem.dart';
import 'package:picspeak_front/views/chat/individual_chat.dart';
import 'package:picspeak_front/views/chat/chat_list_item.dart';
import 'package:picspeak_front/services/chat_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(ChatList());

Future<List<FriendSuggestion>> getSuggestFriends() async {
  List<FriendSuggestion> friendSuggestions = [];

  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiResponse response = await getSuggestFriend(pref.getInt('userId'));

    if (response.error == null) {
      var list = response.data as List;

      friendSuggestions = list
          .map((item) => FriendSuggestion(
              item['id'] ?? 0, item['name'] ?? "", item['photo_url'] ?? ""))
          .toList();
    } else {
      print("Error getSuggestFriends: ${response.error}");
    }
  } catch (e) {
    print('$e');
    // Handle error if needed
  }

  return friendSuggestions;
}

Future<List<Contact>> getContacts() async {
  List<Contact> contacts = [];

  try {
    SharedPreferences pref = await SharedPreferences.getInstance();

    print("EN GET CONTACTOS");
    ApiResponse response = await getContact(pref.getInt('userId'));

    if (response.error == null) {
      var list = response.data as List;
      print("ENTRA EN IF CONTACTOS");
      contacts = list
          .map((item) => Contact(item['id'] ?? 0, item['nickname'] ?? "",
              item['photo_url'] ?? "", item["contactId"] ?? 0))
          .toList();
    } else {
      print("Error contacto: ${response.error}");
    }
  } catch (e) {
    print('$e');
    // Handle error if needed
  }

  return contacts;
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatListScreen(),
    );
  }
}

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<FriendSuggestion> friendSuggestions = [];
  //List<Chat> chatList = [];
  List<Contact> contactList = [];

  @override
  void initState() {
    super.initState();
    loadFriendSuggestions();
    loadContacts();
    // Load other data like chatList and contactList if needed
  }

  Future<void> loadFriendSuggestions() async {
    try {
      List<FriendSuggestion> suggestions = await getSuggestFriends();
      setState(() {
        friendSuggestions = suggestions;
      });
    } catch (e) {
      print("Error loading friend suggestions: $e");
    }
  }

  Future<void> loadContacts() async {
    try {
      List<Contact> contacts = await getContacts();
      setState(() {
        contactList = contacts;
      });
    } catch (e) {
      print("Error loading friend suggestions: $e");
    }
  }

  final List<Chat> chatList = [
    Chat("Usuario 1", "Hola, ¿cómo estás?", "10:00 AM",
        'assets/imagenes/avatar1.png'),
    Chat("Usuario 2", "¡Hola! Estoy bien, ¿y tú?", "10:15 AM",
        'assets/imagenes/avatar2.png'),
    // Agrega más chats aquí...
  ];

  // final List<Contact> contactList = [
  //   Contact("Contacto 1", 'assets/imagenes/avatar1.png'),
  //   Contact("Contacto 2", 'assets/imagenes/avatar2.png')
  // ];

  // final List<FriendSuggestion> friendSuggestions = [
  //   FriendSuggestion("Amigo Sugerido 1", 'assets/imagenes/avatar2.png'),
  //   FriendSuggestion("Amigo Sugerido 2", 'assets/imagenes/avatar2.png'),
  //   // Agrega más sugerencias de amigos aquí...
  // ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: const TabBar(
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
                Expanded(
                  child: ListView.builder(
                    itemCount: contactList.length +
                        (friendSuggestions.isNotEmpty ? 2 : 1),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Primer elemento: Lista de contactos
                        return Column(
                          children: [
                            for (final contact in contactList)
                              ContactListItem(contact),
                          ],
                        );
                      } else if (index == 1 && friendSuggestions.isNotEmpty) {
                        // Segundo elemento: Título "Sugerencias"
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 16.0), // Ajusta según sea necesario
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sugerencias",
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // Resto de elementos: Lista de sugerencias de amigos o mensaje de no hay sugerencias
                        final friendIndex =
                            index - (friendSuggestions.isNotEmpty ? 2 : 1);
                        return friendIndex < friendSuggestions.length
                            ? FriendSuggestionItem(
                                suggestion: friendSuggestions[friendIndex],
                                onPressed: () {
                                  loadFriendSuggestions();
                                  loadContacts();
                                },
                              )
                            : friendSuggestions.isEmpty &&
                                    index ==
                                        contactList.length +
                                            (friendSuggestions.isNotEmpty
                                                ? 1
                                                : 0)
                                ? Container(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 16.0),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "No hay sugerencias de amigos",
                                        style: TextStyle(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(); // Elemento vacío para cuando no haya sugerencias y no se quiera mostrar nada más
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class IndividualChatScreen extends StatefulWidget {
  final Chat chat;

  const IndividualChatScreen(this.chat);

  @override
  IndividualChatScreenState createState() => IndividualChatScreenState();
}
