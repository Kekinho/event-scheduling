import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Signboard extends StatelessWidget {
  const Signboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20,
        ),
        child: AnimatedTextKit(
          pause: Duration.zero,
          repeatForever: true,
          animatedTexts: [
            FadeAnimatedText('Programação'),
            FadeAnimatedText('Palestrantes'),
            FadeAnimatedText('Boletins Informativos'),
            FadeAnimatedText('Patrocínios'),
            FadeAnimatedText('Lorenzo'),
          ],
        ),
      ),
    );
   }
}
