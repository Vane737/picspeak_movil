// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:picspeak_front/models/contact_model.dart';
import 'package:picspeak_front/presentation/screens/user_information/view_profile_screen.dart';
import 'package:picspeak_front/views/chat/individual_chat.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ContactListItem extends StatelessWidget {
  final ContactModel contact;
  final io.Socket socket;

  const ContactListItem(this.contact, this.socket);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      leading: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ViewProfileScreen(id: contact.contactId)),
                );
              },
              child: CircleAvatar(
                radius: 30.0,
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        contact.imageAsset,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      title: Row(
        children: [
          const Text(
            "🇺🇸",
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            contact.nickname,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      /* trailing: IconButton(
        icon: const Icon(
            Icons.chat), // Icono del botón de chat (puedes personalizarlo)
        onPressed: () {
          print("presiona el boton para entrar al chat");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  IndividualChatScreen(contact.chat, socket)));
        },
      ), */
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => IndividualChatScreen(contact.chat, socket)));
      },
    );
  }
}
