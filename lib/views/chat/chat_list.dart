// ignore_for_file: use_key_in_widget_constructors, avoid_print, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:picspeak_front/config/constants/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:picspeak_front/config/theme/app_colors.dart';
import 'package:picspeak_front/config/theme/app_fonts.dart';
import 'package:picspeak_front/main.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/models/chat_model.dart';
import 'package:picspeak_front/models/friend_suggestion_model.dart';
import 'package:picspeak_front/models/contact_model.dart';
import 'dart:convert';
import 'package:picspeak_front/views/user_information/edit_profile_screen.dart';
import 'package:picspeak_front/views/user_information/view_profile_screen.dart';
import 'package:picspeak_front/services/notification_service.dart';
import 'package:picspeak_front/views/widgets/custom_button.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:picspeak_front/views/widgets/contact_list_item.dart';
import 'package:picspeak_front/views/widgets/friend_suggestion_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:picspeak_front/services/chat_service.dart';
import 'package:picspeak_front/views/chat/chat_list_item.dart';

void main() => runApp(ChatList());

Future<List<FriendSuggestionModel>> getSuggestFriends() async {
  List<FriendSuggestionModel> friendSuggestions = [];

  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiResponse response = await getSuggestFriend(pref.getInt('userId'));

    if (response.error == null) {
      var list = response.data as List;
      friendSuggestions = list
          .map((item) => FriendSuggestionModel(
              item['id'] ?? 0, item['name'] ?? "", item['photo_url'] ?? ""))
          .toList();
    } else {
      print("Error getSuggestFriends: ${response.error}");
    }
  } catch (e) {
    print('$e');
  }

  return friendSuggestions;
}

Future<List<ContactModel>> getContacts() async {
  List<ContactModel> contacts = [];

  try {
    SharedPreferences pref = await SharedPreferences.getInstance();
    ApiResponse response = await getContact(pref.getInt('userId'));

    if (response.error == null) {
      var list = response.data as List;
      contacts = list
          .map((item) => ContactModel(
              item['id'] ?? 0,
              item['nickname'] ?? "",
              item['photo_url'] ?? "",
              item["contactId"] ?? 0,
              ChatListModel(
                  userId: item['chat']['userId'],
                  chatId: item['chat']['id'],
                  originalUserId: pref.getInt('userId') ?? 0,
                  otherUserId: item['contactId'],
                  otherUserPhoto: item['photo_url'],
                  otherUserUsername: item['nickname'])))
          .toList();
    } else {
      print("Error contacto: ${response.error}");
    }
  } catch (e) {
    print('$e');
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

class _ChatListScreenState extends State<ChatListScreen>
    with SingleTickerProviderStateMixin {
  List<FriendSuggestionModel> friendSuggestions = [];
  List<ContactModel> contactList = [];
  late io.Socket socket;
  bool isConnected = false;
  late TabController _tabController;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.initNotification();
    _tabController = TabController(length: 2, vsync: this);
    //fetchChatData();
    loadFriendSuggestions();
    loadContacts();
    initSocket();
  }

  initSocket() {
    socket = io.io(socketUrl, <String, dynamic>{
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
    _tabController.dispose();
    socket.dispose();
    super.dispose();
  }

  Future<void> loadFriendSuggestions() async {
    try {
      List<FriendSuggestionModel> suggestions = await getSuggestFriends();
      setState(() {
        friendSuggestions = suggestions;
      });
    } catch (e) {
      print("Error loading friend suggestions: $e");
    }
  }

  Future<void> loadContacts() async {
    try {
      List<ContactModel> contacts = await getContacts();
      setState(() {
        contactList = contacts;
      });
    } catch (e) {
      print("Error loading friend suggestions: $e");
    }
  }

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
                    onSelected: (choice) async {
                      if (choice == 'Perfil') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      } else if (choice == 'Información') {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        int? userId = pref.getInt('userId');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewProfileScreen(id: userId),
                          ),
                        );
                        //DEBE MOSTRAR LA PANTALLA DE INFORMACIONES DEL PERFIL, COMO ESTADO, INTERESES, CONTENIDO INAPROPIADO
                      } else if (choice == 'Ajustes') {
                        // Lógica para abrir la pantalla de amigos.
                      } else if (choice == 'Cerrar Sesión') {
                        // Lógica para abrir la pantalla de amigos.
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmación'),
                            content: const Text(
                                '¿Estás seguro de querer cerrar sesión?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cerrar Sesión'),
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.remove('userId');
                                  await prefs.remove('token');
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        'Perfil',
                        'Información',
                        'Ajustes',
                        'Cerrar Sesión'
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
            controller: _tabController,
            tabs: const [
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
                'Amigos',
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
          controller: _tabController,
          children: [
            Column(
              children: [
                ChatListView( tabController: _tabController, socket: socket),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      final contact = contactList[index];
                      return ContactListItem(contact, socket);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Sugerencias",
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: friendSuggestions.length,
                          itemBuilder: (context, index) {
                            return FriendSuggestionItem(
                              suggestion: friendSuggestions[index],
                              onPressed: () {
                                loadFriendSuggestions();
                                loadContacts();
                              },
                            );
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

class ChatListView extends StatefulWidget {
  final TabController tabController;
  final io.Socket socket;

  const ChatListView({required this.tabController, required this.socket});

  @override
  _ChatListViewState createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final List<Map<String, dynamic>> _chatData = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController;
    if (_chatData.isEmpty) {
      fetchChatData(); 
    }
  }

  Future<List<Map<String, dynamic>>> fetchChatData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt('userId');
    final response = await http.get(Uri.parse('$chatsByUserUrl/users/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load chat data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _chatData.isNotEmpty ? Future.value(_chatData) : fetchChatData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Map<String, dynamic>> chatData = snapshot.data!;
          if (chatData.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    '¡Bienvenido! Conéctate con personas de todos los lugares del mundo.',
                    style: AppFonts.heading3Style,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    alignment: MainAxisAlignment.spaceBetween,
                    icon: Icons.person_add_alt_rounded,
                    text: 'Conectar con amigos',
                    color: AppColors.bgPrimaryColor,
                    width: 240,
                    onPressed: () {
                      _tabController.animateTo(1);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                itemCount: chatData.length,
                itemBuilder: (context, index) {
                  final chatMap = chatData[index];
                  final chat = ChatListModel(
                    userId: chatMap['userId'],
                      chatId: chatMap['chat_id'],
                      originalUserId: chatMap['original_user_id'],
                      originalUserMaternLanguage:
                          chatMap['original_user_matern_language'],
                      otherUserId: chatMap['other_user_id'],
                      otherUserName: chatMap['other_user_name'],
                      otherUserLastname: chatMap['other_user_lastname'],
                      otherUserUsername: chatMap['other_user_username'],
                      otherUserPhoto: chatMap['other_user_photo'],
                      otherUserNacionality: chatMap['other_user_nacionality'],
                      otherUserMaternLanguage:
                          chatMap['other_user_matern_language'],
                      messageUserId: chatMap['message_user_id'],
                      messageDatetime: chatMap['message_datetime'] != null
                          ? DateTime.tryParse(chatMap['message_datetime'] ?? '')
                          : null,
                      messageTextOrigin:
                          chatMap['message_text_origin'] ?? '📷 Foto',
                      messageTextTranslate:
                          chatMap['message_text_translate'] ?? '📷 Foto');
                  return ChatListItem(chat, widget.socket);
                },
              ),
            );
          }
        }
      },
    );
  }
}
