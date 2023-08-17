
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wticifesapp/data/data_schedule.dart';
import 'package:wticifesapp/page/common/app_name_widget.dart';
import 'package:wticifesapp/page/component/item_schedule.dart';
import 'package:wticifesapp/page/component/item_speakers.dart';

class SpeakersTab extends StatefulWidget {
  const SpeakersTab({Key? key}) : super(key: key);

  @override
  State<SpeakersTab> createState() => _SpeakersTabState();
}

class _SpeakersTabState extends State<SpeakersTab> {
  _SpeakersTabState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(213, 180, 126, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(213, 180, 126, 1),
        elevation: 0,
        centerTitle: true,
        title: AppNameWidget(),
      ),
      body: Container(
        color: Color.fromRGBO(76, 11, 28, 1),
        child: SafeArea(
          child: Column(
              children: [
              Expanded(
              child: SpeakersItem(),
        ),
        ]
        ),
    ),
      ),
    );
  }
}
