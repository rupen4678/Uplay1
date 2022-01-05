import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPlayer extends StatefulWidget {
  final String url1;
  const VideoPlayer(this.url1);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late BetterPlayerController _betterPlayerController;

  late String url1;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, url1);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }
}
