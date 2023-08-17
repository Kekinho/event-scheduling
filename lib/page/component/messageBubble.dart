import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:wticifesapp/model/speaker.dart';

class MessageBubble extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final Speaker speaker;
  final bool belongsToCurrentUser;

  const MessageBubble({
    Key? key,
    required this.speaker,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  Widget _showUserImage(String imageURL) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);

    if (uri.scheme.contains('https')) {
      print(uri.toString());
      provider = NetworkImage(uri.toString());
    } else  if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    }


    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  Widget _showImage(String imageURL) {

    return Image.network(
      imageURL,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey.shade300
                    : Colors.grey.shade300,//Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: belongsToCurrentUser
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: belongsToCurrentUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 315,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: belongsToCurrentUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    speaker.name,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors
                          .black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Cargo: ${speaker.charge}",
                    textAlign:
                    belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors
                          .black,
                    ),
                  ),
                  Text(
                    "Assunto: ${speaker.topic}",
                    textAlign:
                    belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors
                          .black,
                    ),
                  ),
                  Text(
                      speaker.description,
                      textAlign:
                      belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                      style: TextStyle(
                        color: belongsToCurrentUser ? Colors.black : Colors
                            .black,
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 300,
          right: belongsToCurrentUser ? 300 : null,
          child: _showUserImage(speaker.photo),
        ),
      ],
    );
  }
}
