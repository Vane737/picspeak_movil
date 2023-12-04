import 'package:flutter/material.dart';
import 'package:picspeak_front/models/chat.dart';
// import 'package:picspeak_front/views/chat/Chat.dart';
// import 'package:picspeak_front/views/chat/ChatList.dart';
import 'package:picspeak_front/views/chat/Contact.dart';
import 'package:picspeak_front/views/chat/chat_list.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;

  ContactListItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30.0,
            child: Image.asset(
              contact.contactImageAsset,
              width: 60.0,
              height: 60.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      title: Row(
        children: [
          Text(
            "🇺🇸",
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            contact.contactName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon:
            Icon(Icons.chat), // Icono del botón de chat (puedes personalizarlo)
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => IndividualChatScreen(
                Chat(contact.contactName, "", "", contact.contactImageAsset)),
          ));
        },
      ),
      onTap: () {
        // Puedes mantener esta lógica si también quieres que algo suceda cuando se toca el ListTile
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => IndividualChatScreen(chat),
        // ));
      },
    );
  }
}
