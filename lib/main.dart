import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
//import 'screens/playvideo.dart';
import 'screens/betterPlayyer.dart';
import 'config/routers.dart';
import 'config/keys.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: AppRouter.navigatorKey,
        home: YouTubeSearch());
  }
}

// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, avoid_print

class YouTubeSearch extends StatefulWidget {
  static TextEditingController ytsearch = TextEditingController();

  @override
  //late TextEditingController ytsearch;
  _YouTubeSearchState createState() => _YouTubeSearchState();
}

class _YouTubeSearchState extends State<YouTubeSearch> {
  bool typing = false;

  String header = "Search";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];

  _write(List text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/youtube_data.txt');
    await file.writeAsString(text.toString());
    print('file Wrote');
  }

  Future<void> callAPI() async {
    videoResult = await youtube.search(
      YouTubeSearch.ytsearch.text,
      order: 'relevance',
      videoDuration: 'any',
    );
    videoResult = await youtube.nextPage();
    setState(() {
      print('ran inside void future');
      _write(videoResult);
    });
  }

  @override
  void initState() {
    super.initState();
    //YouTubeSearch.ytsearch = TextEditingController();
    //callAPI();
  }

  void myFunction() {
    return print("someting");
  }

  @override
  Widget build(BuildContext context) {
    //YouTubeSearch.ytsearch = TextEditingController();
    final text = YouTubeSearch.ytsearch.text;
    final generatedList = List.generate(500, (index) => 'Item $index');
    List someList =
        List.generate(500, (index) => '${YouTubeSearch.ytsearch}.text $index');

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 100 * 12,
          title: Container(
            child: Column(
              children: [
                Row(children: [
                  Container(
                    child: IconButton(
                        icon: Image.asset('assets/images/logo.png'),
                        onPressed: () {
                          AppRouter.push(VideoPlayer(
                              'https://www.youtube.com/watch?v=WVVMMPVUUxY&list=RDWVVMMPVUUxY&start_radio=1'));
                        }),
                  ),
                  Center(child: Text('Uplay')),
                ]),
                //SizedBox(
                //height: 10,
                //),
                Container(
                  child: SizedBox(
                    height: 40,
                    width: 250,
                    child: Expanded(
                      child: TextField(
                        controller: YouTubeSearch.ytsearch,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5, left: 15),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                //String so = TextBox.ytsearch.text;
                                // ListObjects(someList);
                                callAPI();
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'What are u looking today?',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          children: videoResult.map<Widget>(ListItem).toList(),
        ) //ListObjects(someList),
        );
  }
}

Widget ListItem(YouTubeVideo video) {
  return Card(
    color: Colors.white,
    // ignore: unnecessary_new

    child: Container(
      margin: EdgeInsets.symmetric(vertical: 7.0),
      padding: EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          print('id of the video ${video.url}');
          //Router.push(MyPlayerYoutube(video.url));
        },
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
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      video.channelTitle,
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class ListObjects extends StatelessWidget {
  final generatedList;
  const ListObjects(this.generatedList);
  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 150.0,
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          title: Text(
            generatedList[index],
            style: TextStyle(fontSize: 29.0),
          ),
        ),
        childCount: generatedList.length,
      ),
    );
  }
}

//below are useless codes for now

Widget listItem(YouTubeVideo video) {
  return Card(
    child: Container(
      child: Image.network(
        video.thumbnail.small.url ?? 'No image',
        width: 20.0,
      ),
    ),
    // ignore: unnecessary_new

    // child: Container(
    //   margin: EdgeInsets.symmetric(vertical: 7.0),
    //   padding: EdgeInsets.all(12.0),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Container(
    //         child: Image.network(
    //           video.thumbnail.small.url ?? 'No image',
    //           width: 20.0,
    //         ),
    //       ),
    //       Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               video.title,
    //               softWrap: true,
    //               style: TextStyle(fontSize: 18.0, color: Colors.grey[500]),
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //             Padding(
    //               padding: EdgeInsets.symmetric(vertical: 3.0),
    //               child: Text(
    //                 video.channelTitle,
    //                 softWrap: true,
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold, color: Colors.white),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
  );
}

// class TextBox extends StatelessWidget {
//   //static TextEditingController ytsearch = TextEditingController();

//   String test() {
//     print('test method is called with ${YouTubeSearch.ytsearch.text}');
//     return YouTubeSearch.ytsearch.text;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 45,
//       child: TextField(
//         controller: YouTubeSearch.ytsearch,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(top: 5, left: 15),
//             suffixIcon: IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 //String so = .text;
//                 // ListObjects(someList);
//                 YouTubeSearch().callAPI();
//               },
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             hintText: 'What are u listing today?',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//             )),
//       ),
//     );
//   }
// }

// class Other_widgets extends StatelessWidget {
//   @override
//   final YouTubeSearch callMe = new YouTubeSearch();
//   Widget build(BuildContext context) {
//     return Container(
//         alignment: Alignment.topRight,
//         child: FloatingActionButton(
//           onPressed: () {
//             YouTubeSearch;
//           },
//         ));
//   }
// }
