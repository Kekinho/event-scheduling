import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/notificationservice.dart';
import 'common/app_name_widget.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({Key? key}) : super(key: key);

  @override
  State<NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();

  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<NotificationService>(context);
    final items = service.items;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(213, 180, 126, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(213, 180, 126, 1),
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
      ),
      body: Container(
        color: const Color.fromRGBO(76, 11, 28, 1),
        child: ListView.builder(
          itemCount: service.itemsCount,
          itemBuilder: (ctx, i) => Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            color: const Color.fromRGBO(213, 180, 126, 0.8),
            child: ListTile(
              title: Text(items[i].title, style: TextStyle(color: Colors.white),),
              subtitle: Text(items[i].body,style: TextStyle(color: Colors.black),),
              onTap: () => service.remove(i),
            ),
          ),
        ),
      ),
    );
  }
}
