import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/profile.dart';
import '../model/ranking.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  var imagelist = [];
  getdata() async {
    var collection =
        await FirebaseFirestore.instance.collection('ranksort').get();
    imagelist = collection.docs
        .map((doc) => Ranking(
              imgurl: doc['imgurl'],
              total: doc['finaltotal'],
              profurl: doc['profurl'],
              // imageAsset: doc['imgurl']
            ))
        .toList();
    // print(imagelist[0].imageAsset);
    print(imagelist);
    // this.draggableItems = draggableItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text(widget.title)),
        // backgroundColor: Colors.transparent,
        body: Center(
      child: FutureBuilder<dynamic>(
        future: getdata(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
              appBar: AppBar(
                // backgroundColor: Colors.blue.withOpacity(0.3),
                centerTitle: false,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Text(
                  "👑Today's Ranking👑",
                  // "Today's Ranking",

                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    // fontSize: 24,
                  ),
                ),
              ),
              body: Container(
                width: double.infinity,
                child: ListView(
                  // padding: EdgeInsets.only(bottom: 2.0),
                  cacheExtent: 0.0,
                  // 各アイテムの高さを100.0に統一
                  // itemExtent: 700.0,
                  children: [
                    for (var i = 0; i < imagelist.length; i++) ...[
                      Container(
                        // color: Color.fromARGB(255, 249, 170, 35),
                        color: Colors.white,
                        // padding: const EdgeInsets.only(bottom:4.0),
                        child: Column(
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //   border: Border(
                              //     // top: BorderSide(
                              //     //   color: Colors.black,width: 4
                              //     // ),
                              //     left: BorderSide(
                              //         color: Colors.yellow, width: 16),
                              //     right: BorderSide(
                              //         color: Colors.yellow, width: 16),
                              //   ),
                              // ),
                              width: double.infinity,
                              // color: Colors.grey,
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 72,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(imagelist[i].profurl),
                                    ),
                                    SizedBox(
                                      width: 72,
                                    ),
                                    Text(
                                      'No.${i + 1}   👍${imagelist[i].total}',
                                      //  style: GoogleFonts.fredokaOne(
                                      //     fontSize: 40,
                                      //   ),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Image.network(
                              imagelist[i].imgurl,
                              fit: BoxFit.contain,
                            ),

                          ],
                        ),
                        // const Divider(),
                      ),
                    ],
                  ],
                ),
              ));
        },
      ),
    ));
  }
}
