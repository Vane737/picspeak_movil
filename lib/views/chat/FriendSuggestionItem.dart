import 'package:flutter/material.dart';
import 'package:picspeak_front/views/chat/FriendSuggestion.dart';

class FriendSuggestionItem extends StatelessWidget {
  final FriendSuggestion suggestion;

  FriendSuggestionItem(this.suggestion);

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
              suggestion.friendImageAsset,
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
            suggestion.friendName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons
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
