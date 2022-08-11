import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class RankContent {
  String id = "";
  int score = 0;

  RankContent(this.id, this.score);
}

List<RankContent> rankContentList = [
  RankContent("Parker", 20),
  RankContent("Petter", 10),
];

class _RankingPageState extends State<RankingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("랭킹"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                Widget>[
          DefaultTabController(
              length: 4, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: TabBar(
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(text: '상식 퀴즈'),
                          Tab(text: '음식 퀴즈'),
                          Tab(text: '인물 퀴즈'),
                          Tab(text: '나라 퀴즈'),
                        ],
                      ),
                    ),
                    Container(
                        height: 400, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          Container(
                              child: ListView.builder(
                                  itemCount: rankContentList.length,
                                  itemBuilder: ((context, index) {
                                    RankContent content =
                                        rankContentList[index];
                                    return Container(
                                      height: 80,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        margin: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                (index + 1).toString(),
                                                style: TextStyle(fontSize: 26),
                                              ),
                                              Text(
                                                content.id,
                                                style: TextStyle(fontSize: 26),
                                              ),
                                              Text(
                                                content.score.toString(),
                                                style: TextStyle(fontSize: 26),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }))),
                          Container(
                            child: Center(
                              child: Text('Display Tab 2',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text('Display Tab 3',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text('Display Tab 4',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ]))
                  ])),
        ]),
      ),
    );
  }
}
