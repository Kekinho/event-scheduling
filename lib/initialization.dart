
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wticifesapp/page/base.dart';
import 'package:wticifesapp/services/notificationservice.dart';

import 'loading_page.dart';




class Initialization extends StatelessWidget {
  const Initialization({Key? key}) : super(key: key);

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
    await Provider.of<NotificationService>(
      context,
      listen: false,
    ).init();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return BaseScreen();

        }
      },
    );
  }
}
