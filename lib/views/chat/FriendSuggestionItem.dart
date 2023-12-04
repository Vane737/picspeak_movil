import 'package:flutter/material.dart';
import 'package:picspeak_front/views/chat/FriendSuggestion.dart';

class FriendSuggestionItem extends StatelessWidget {
  final FriendSuggestion suggestion;

  FriendSuggestionItem(this.suggestion);

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
            "🇺🇸",
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
        icon: const Icon(Icons
            .person_add_alt), // Icono del botón de chat (puedes personalizarlo)
        onPressed: () {},
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
