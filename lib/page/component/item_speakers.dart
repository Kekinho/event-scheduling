import 'package:wticifesapp/model/speaker.dart';
import 'package:wticifesapp/services/speaker_service.dart';
import 'messageBubble.dart';

import 'package:flutter/material.dart';

class SpeakersItem extends StatelessWidget {
  SpeakersItem({Key? key}) : super(key: key);
  bool lado = false;
  @override
  Widget build(BuildContext context) {
    //print(SpeakerService().speakerStream().first);
    return StreamBuilder<List<Speaker>>(
      stream: SpeakerService().speakerStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Sem dados.'));
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => MessageBubble(
              key: ValueKey(msgs[i].id),
              speaker: msgs[i],
              belongsToCurrentUser: lado ? lado = !lado : lado = !lado,
            ),
          );
        }
      },
    );
  }
}
