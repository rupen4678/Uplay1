import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MyHome extends StatefulWidget {
  late final videosList;
  static TextEditingController ytText = TextEditingController();

  MyHome(this.videosList) {
    this.videosList = videosList;
  }

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void dispose() {
    MyHome.ytText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = MyHome.ytText.text;
    final generatedList = List.generate(500, (index) => 'Item $index');
    final someList =
        List.generate(500, (index) => '${MyHome.ytText}.text $index');

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Uplay"),
            floating: true,
            actions: <Widget>[
              Center(
                child: IconButton(
                  icon: const Icon(Icons.done),
                  tooltip: 'Add new entry',
                  onPressed: () {/* ... */},
                ),
              ),
            ],
            bottom: AppBar(
                title: Container(
                    height: 45,
                    child: TextField(
                      controller: MyHome.ytText,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 5, left: 15),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'What are u listing today?',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ))),
            elevation: 20,
          ),
          ListObjects(someList),
        ],
      ),
    );
  }
}

class ListObjects extends StatelessWidget {
  final generatedList;
  // ignore: use_key_in_widget_constructors
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
//later create class taking the constrouter the list of videos and create the silver list
//building a listview taking
