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
                radius: 30.0, // Define el radio del círculo
                backgroundColor: Colors
                    .blue, // Puedes cambiar el color de fondo según tus necesidades
                child: ClipOval(
                  child: Image.network(
                    contact
                        .imageAsset, // Utiliza la ruta de la imagen del chat actual
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
