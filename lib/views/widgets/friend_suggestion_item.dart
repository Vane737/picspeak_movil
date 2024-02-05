// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:picspeak_front/models/api_response.dart';
import 'package:picspeak_front/models/friend_suggestion_model.dart';
import 'package:picspeak_front/services/chat_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendSuggestionItem extends StatelessWidget {
  final FriendSuggestionModel suggestion;
  final VoidCallback onPressed;

  const FriendSuggestionItem({required this.suggestion, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30.0,
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    suggestion.friendImageAsset,
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
            "🇺🇸", //cambiar icon
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            suggestion.friendName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.person_add_alt), // Icono del botón de chat (puedes personalizarlo)
        onPressed: () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          ApiResponse response =
              await addSuggest(pref.getInt('userId'), suggestion.id);
          if (response.error == null) {
            onPressed(); // Llama a la función de devolución de llamada después de realizar la acción
          } else {
            print("ERROR on press: ${response.error}");
          }
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