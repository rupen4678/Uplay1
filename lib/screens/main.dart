// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, avoid_print
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:uplay/main2.dart';
import 'package:youtube_api/youtube_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: YouTubeSearch());
  }
}

class YouTubeSearch extends StatefulWidget {
  @override
  _YouTubeSearchState createState() => _YouTubeSearchState();
}

class _YouTubeSearchState extends State<YouTubeSearch> {
  bool typing = false;

  static String key = "AIzaSyCv_5tp07k_dkXxsr2xxsKMhTYuRugQUaI";
  String header = "Search";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    videoResult = await youtube.search(
      TextBox.ytsearch.text,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  void myFunction() {
    return print("someting");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.grey[900],
        title: typing ? TextBox() : Text(header),
        leading: IconButton(
          icon: Icon(typing ? Icons.done : Icons.search),
          onPressed: () {
            setState(() {
              typing = !typing;
            });
            if (typing == false) {
              callAPI();
            }
            // ignore: unnecessary_null_comparison
            if (TextBox.ytsearch.text == null) {
              header = 'Type Here??';
            } else {
              header = TextBox.ytsearch.text;
            }
          },
        ),
      ),
      body: ListView(
        children: videoResult.map<Widget>(listItem).toList(),
      ),
    );
  }
}

Widget listItem(YouTubeVideo video) {
  return Card(
    color: Colors.grey[850],
    // ignore: unnecessary_new

    child: Container(
      margin: EdgeInsets.symmetric(vertical: 7.0),
      padding: EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.network(
              video.thumbnail.small.url ?? '',
              width: 80.0,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  video.title,
                  softWrap: true,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey[500]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    video.channelTitle,
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class TextBox extends StatelessWidget {
  static TextEditingController ytsearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: TextField(
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
          controller: ytsearch,
        ),
      ),
    );
  }
}
