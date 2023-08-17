import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wticifesapp/model/event_schedule.dart';

class PageDetails extends StatelessWidget {
  final Speaker event_schedule;
  const PageDetails({Key? key, required this.event_schedule }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Card(child: Text(event_schedule.detail)),
    );
  }
}

