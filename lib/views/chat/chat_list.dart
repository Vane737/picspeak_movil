// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/views/chat/chat_list_item.dart';
import 'dart:convert';
import 'package:picspeak_front/presentation/screens/user_information/edit_profile_screen.dart';
import 'package:picspeak_front/presentation/screens/user_information/view_profile_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:picspeak_front/models/chat.dart';
// import 'package:picspeak_front/views/chat/Chat.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/views/chat/Contact.dart';
import 'package:picspeak_front/views/chat/ContactListItem.dart';
import 'package:picspeak_front/views/chat/FriendSuggestion.dart';
import 'package:picspeak_front/views/chat/FriendSuggestionItem.dart';
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
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatListScreen extends StatefulWidget {
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<FriendSuggestion> friendSuggestions = [];
  //List<Chat> chatList = [];
  List<Contact> contactList = [];
  State<ChatListScreen> createState() => _ChatListScreenState();
  late io.Socket socket;
  bool isConnected = false;

  Future<List<Map<String, dynamic>>> fetchChatData() async {
     SharedPreferences pref = await SharedPreferences.getInstance();
    final urlChat = '{$chatsByUserUrl${pref.getInt("userId")}';
    print("URL CHAT: $urlChat");

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
    loadFriendSuggestions();
    loadContacts();
    // Load other data like chatList and contactList if needed
  }

  initSocket() {
    socket = io.io('http://192.168.1.140:3000', <String, dynamic>{
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
        ),
        actions: [
          Container(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            fontSize: 16,
                            color: Color.fromARGB(255, 248, 248, 248),
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
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchChatData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final List<Map<String, dynamic>> chatData = snapshot.data!;
                  print("IMPRIMIENDO CHATDATA***********: $chatData"); // Agrega esta línea para imprimir los datos
                  return ListView.builder(
                    itemCount: chatData.length,
                    itemBuilder: (context, index) {
                      final chatMap = chatData[index];
                      final chat = ChatListModel(
                        id: chatMap['chatId'],
                        receivingUserId: chatMap['resuserid'],
                        receivingUsername: chatMap['resusername'],
                        receivingUserPhoto: chatMap['resuserphoto'],
                        receivingUserNation: chatMap['resusernation'],
                        message: chatMap['message'],
                        timeMessage: chatMap['hora'] != null
                            ? DateTime.parse(chatMap['hora'])
                            : null,
                      );
                      return ChatListItem(chat, socket);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* class IndividualChatScreen extends StatefulWidget {
  final ChatListModel chat;
  //final io.Socket connectionSocket;

  const IndividualChatScreen(this.chat, socket);

  @override
  IndividualChatScreenState createState() => IndividualChatScreenState();
} */
