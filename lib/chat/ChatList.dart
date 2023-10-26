import 'package:flutter/material.dart';

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
    Chat("Usuario 1", "Hola, ¿cómo estás?", "10:00 AM"),
    Chat("Usuario 2", "¡Hola! Estoy bien, ¿y tú?", "10:15 AM"),
    Chat("Usuario 3", "Buenos días.", "10:30 AM"),
    // Agrega más chats aquí...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Chats'),
      ),
      body: ListView.builder(
        itemCount: chatList.length,
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return ChatListItem(chat);
        },
      ),
    );
  }
}

class Chat {
  final String senderName;
  final String lastMessage;
  final String time;

  Chat(this.senderName, this.lastMessage, this.time);
}

class ChatListItem extends StatelessWidget {
  final Chat chat;

  ChatListItem(this.chat);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // Aquí puedes colocar la foto de perfil del remitente si lo deseas.
        backgroundColor: Colors.blue, // Ejemplo de color de fondo.
        radius: 25.0,
      ),
      title: Text(chat.senderName),
      subtitle: Text(chat.lastMessage),
      trailing: Text(chat.time),
      onTap: () {
        // Navegar a la pantalla de chat individual cuando se hace clic en un chat.
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => IndividualChatScreen(chat),
        ));
      },
    );
  }
}

class IndividualChatScreen extends StatelessWidget {
  final Chat chat;

  IndividualChatScreen(this.chat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.senderName),
      ),
      body: Center(
        child: Text('Pantalla de Chat Individual: ${chat.senderName}'),
      ),
    );
  }
}
