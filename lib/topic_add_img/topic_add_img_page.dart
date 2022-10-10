import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_test/img_list/img_list_model.dart';
import '/domain/image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'topic_add_img_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../topic_page/topic_page.dart';
import '../bottomtab_page/BottomTabPage.dart';

// フラグ管理
var UpFlag = 0;
int UploadFlag() {
  print(UpFlag);
  return UpFlag;
}

class AddImgPage extends StatefulWidget {
  const AddImgPage({Key? key}) : super(key: key);
  @override
  State<AddImgPage> createState() => _AddImgPageState();
}

class _AddImgPageState extends State<AddImgPage> {
  // Firebaseからデータを取得してくる
  List<Post> myPost = [];
  Future<String> getdata() async {
    var collection = await FirebaseFirestore.instance.collection('imags').get();
    String? uid = FirebaseAuth.instance.currentUser!.uid;

    // myPost = collection.docs
    //     .map((doc) => Post(
    //         userid: doc['uid'],
    //         distance: doc['time'],
    //         imageAsset: doc['imgurl']))
    //     .toList();
    var myFirstPost = collection.docs
        .where((doc) => doc['uid'] == uid)
        .map((doc) => doc['imgurl'])
        .toList();
    // print(myPost[0].imageAsset);
    if (myFirstPost.isEmpty) {
      return 'WaitingUpload';
    }
    print(myFirstPost[0]);
    // var myPostImage = myPost[0].imageAsset;
    return myFirstPost[0];
    // this.draggableItems = draggableItems;
  }

  // 書き換える前の画像を定義
  late String myImage =
      'https://www.mordeo.org/files/uploads/2021/07/Loading-Dark-Background-4K-Ultra-HD-Mobile-Wallpaper-scaled.jpg';

  // PostImage関数でfirebaseの値が取得できるように設定
  PostImage() async {
    myImage = await getdata();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    PostImage();
    return Scaffold(
      body: myImage == 'WaitingUpload'
          ? Container(
              // color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        )),
                  ],
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    // 'https://i.pinimg.com/564x/82/c0/70/82c0703007702b271086868d69e03ca0.jpg'),
                    myImage),
                fit: BoxFit.cover,
              )),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // PostImage = await getdata();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'キャンセル',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white.withOpacity(0), //ボタンの背景色
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 0,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // PostImage = await getdata();
                          // setState(() {});
                          UpFlag++;
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomTabPage()),
                          );
                        },
                        child: Text(
                          'あげる',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, //ボタンの背景色
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          shadowColor: Colors.black,
                          elevation: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 0,
                    height: 50,
                  )
                ],
              )),
            ),
    );
  }
}
