import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wticifesapp/model/event_schedule.dart';
import 'package:wticifesapp/page/page_details.dart';
import 'package:video_player/video_player.dart';

import 'control_overlay.dart';

class ScheduleItemSponsors extends StatefulWidget {
  final Speaker event;

  const ScheduleItemSponsors({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _ScheduleItemSponsorsState createState() => _ScheduleItemSponsorsState();
}

class _ScheduleItemSponsorsState extends State<ScheduleItemSponsors> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    //if (widget.event.detail == "sponsor") {
    if (widget.event.detail == "sponsor") {
      _controller = VideoPlayerController.network(
        //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        //  'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//        widget.event.detail == "sponsor" ? widget.event.description : 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        widget.event.description,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      //_controller.setLooping(true);
      _controller.addListener(() {
        setState(() {});
      });

      _initializeVideoPlayerFuture = _controller.initialize();
    }
  //  }
  }

  @override
  void dispose() {
    if (widget.event.detail == "sponsor") {
      _controller.dispose();
    }
    super.dispose();
  }

  _openPageDetails(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return PageDetails(
          event_schedule: widget.event,
        );
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

  Widget futurePlayBuilder() {
    return Column(
      children: [
        ListTile(
          leading: Platform.isIOS
              ? const Icon(
                  CupertinoIcons.money_dollar,
                  color: Colors.white,
                )
              : const Icon(Icons.monetization_on_rounded, color: Colors.white),
          title: Text(
            widget.event.sponsorName,
            style: TextStyle(color: Colors.white),
          ),
          tileColor: Color.fromRGBO(76, 11, 28, 1),
        ),
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  VideoPlayer(_controller),
                  ControlsOverlay(controller: _controller),
                  //VideoProgressIndicator(_controller, allowScrubbing: true)
                ]),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
    //PlayControl(),
  }

  Widget playControl() {
    return Container(
      padding: const EdgeInsets.all(2),
      child: IconButton(
        icon: _controller.value.isPlaying
            ? Icon(Icons.pause)
            : Icon(Icons.play_arrow),
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
      ),
    );
  }

  Widget Sponsor() {
    return futurePlayBuilder();
  }

  Widget Event() {
    return ListTile(
      title: Text(
        widget.event.place == ""
            ? widget.event.description
            : widget.event.place,
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
      trailing: MediaQuery.of(context).size.width > 480
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
              icon:
                  Platform.isIOS ? Icon(CupertinoIcons.info) : Icon(Icons.info),
              color: Colors.deepPurple,
              onPressed: () => _openPageDetails(context),
            ),
    );
  }

  Widget EventOrSponsor() {
    if (widget.event.detail != "sponsor") {
      return Event();
    } else {
      return Sponsor();
    }
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
      child: EventOrSponsor(),
    );
  }
}
