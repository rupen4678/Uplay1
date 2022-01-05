import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:ui';
import 'package:uplay/config/routers.dart';

class MyPlayerYoutube extends StatefulWidget {
  final String? youtubeURL;
  const MyPlayerYoutube(this.youtubeURL);

  @override
  _MyPlayerYoutubeState createState() => _MyPlayerYoutubeState();
}

class _MyPlayerYoutubeState extends State<MyPlayerYoutube> {
  late YoutubePlayerController _controller;
  var isEnabled = true;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId:
            YoutubePlayerController.convertUrlToId(widget.youtubeURL!)!,
        params: const YoutubePlayerParams(
          autoPlay: true,
          color: 'black',
          strictRelatedVideos: true,
          showFullscreenButton: true,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final Ssize = window.physicalSize;
    var kIsWeb;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 55,
        toolbarOpacity: 0.5,
        centerTitle: true,
        title: Container(
          child: const Text(
            'Uplay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 27.0,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        child: YoutubePlayerControllerProvider(
          controller: _controller,
          child: YoutubePlayerIFrame(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
