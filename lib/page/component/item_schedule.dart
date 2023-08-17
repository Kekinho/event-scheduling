import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wticifesapp/model/event_schedule.dart';
import 'package:wticifesapp/page/page_details.dart';

class ScheduleItem extends StatefulWidget {
  final Speaker event;

  const ScheduleItem({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _ScheduleItemState createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {

  _openPageDetails(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return PageDetails(event_schedule: widget.event,);
      },
    );
  }

  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      color: const Color.fromRGBO(213, 180, 126, 0.8),
      child: ListTile(
        title: Text(
          widget.event.place == "" ? widget.event.description : widget.event.place,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.event.description),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  widget.event.hour,
                  style: const TextStyle(
                    height: 0.8,
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
/*        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                icon: Icon(Icons.analytics_outlined,
                    color: Theme.of(context).colorScheme.error),
                label: Text(
                  'Detalhes',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onPressed: () => _openPageDetails(context),
              )
            : IconButton(
                icon: Platform.isIOS ? Icon(CupertinoIcons.info) : Icon(Icons.info),
                color: Colors.deepPurple,
                onPressed: () => _openPageDetails(context),
              ),*/
      ),
    );
  }
}
