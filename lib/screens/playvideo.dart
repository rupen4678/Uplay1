import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'dart:ui';
import 'package:uplay/config/routers.dart';
import 'package:easy_pip/easy_pip.dart';

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
        title: Container(
          child: Text('Uplay'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: PIPStack(
        backgroundWidget: Center(
            child: FloatingActionButton(
          onPressed: () {
            setState(() {
              isEnabled = !isEnabled;

              String s = isEnabled ? 'enabled pip' : 'disabled pip';
              print('running pip');
              print(s);
            });
          },
          child: Icon(Icons.navigation),
        )),
        pipWidget: isEnabled
            ? SizedBox(
                height: 250,
                child: YoutubePlayerControllerProvider(
                  controller: _controller,
                  child: YoutubePlayerIFrame(
                    controller: _controller,
                  ),
                ),
              )
            : Container(child: const Text('sorry not running the pip')),
        pipEnabled: isEnabled,
        pipExpandedContent: Container(child: Text('This area is not in pip ')),
        onClosed: () {
          setState(() {
            isEnabled = !isEnabled;
          });
        },
      ),
    );
  }
}
