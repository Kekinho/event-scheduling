import 'package:flutter/material.dart';
import 'package:wticifesapp/page/notifications_tab.dart';
import 'package:wticifesapp/page/speakers_tab.dart';
import 'package:wticifesapp/page/sponsors_tab.dart';
import 'schedule_tab.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';


class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          ScheduleTab(),
          SpeakersTab(),
          NotificationsTab(),
          SponsorsTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.jumpToPage(index);
            // pageController.animateToPage(
            //   index,
            //   duration: const Duration(milliseconds: 500),
            //   curve: Curves.easeInOutQuart,
            // );
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(76, 11, 28, 0.9),//Color.fromRGBO(213, 180, 126, 1),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(100),
        items: [
          BottomNavigationBarItem(
            icon: !Platform.isIOS ? Icon(Icons.access_time_filled_rounded) : Icon(CupertinoIcons.alarm),
            label: 'Programação',
          ),
          BottomNavigationBarItem(
            icon: !Platform.isIOS ? Icon(Icons.account_box) : Icon(CupertinoIcons.person_crop_rectangle),
            label: 'Palestrantes',
          ),
          BottomNavigationBarItem(
            icon: !Platform.isIOS ? Icon(Icons.list) : Icon(CupertinoIcons.mail),
            label: 'Boletins',
          ),
          BottomNavigationBarItem(
            icon: !Platform.isIOS ? Icon(Icons.monetization_on_rounded) : Icon(CupertinoIcons.money_dollar_circle),
            label: 'Patrocínios',
          ),

        ],

      ),
    );
  }
}