import 'dart:io';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import '../add_img/add_img_page.dart';
import 'topic_add_img_page.dart';

// 認証情報
import 'package:firebase_auth/firebase_auth.dart';

class AddImgModel extends ChangeNotifier {
  //値が入るまではnullだから、? でnullを許容する形にしてあげる
  String? title;
  String? subtitle;
  File? imageFile;
  int? count;
  bool isLoading = false;

  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  //firebaseの変更をリッスンしている
  Future<void> addImg() async {
    // if (title == null) {
    //   throw 'タイトルが入力されていません。';
    // }

    // if (subtitle == null) {
    //   throw '説明が入力されていません。';
    // }
    String? userid = FirebaseAuth.instance.currentUser!.uid;

    final doc = FirebaseFirestore.instance.collection('imags').doc();

    // storageにアップロード
    String? imgurl;
    String? cloudurl;
    if (imageFile != null) {
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('images/${doc.id}')
          .putFile(imageFile!);
      imgurl = await task.ref.getDownloadURL();
      cloudurl =
          'https://storage.cloud.google.com/fir-flutter-sample-2ee98.appspot.com/images/${doc.id}';
      title = "gussy";
      subtitle = "igushi";
      count = 0;
    }

// ユーザー名を取得
    var collection = await FirebaseFirestore.instance.collection('users').get();
    var myName = collection.docs
        .where((doc) => doc['uid'] == userid)
        .map((doc) => doc['name'])
        .toList();
    var myProfile = collection.docs
        .where((doc) => doc['uid'] == userid)
        .map((doc) => doc['profurl'])
        .toList();
    print(myName);
    // final now = DateTime.now();
    var posttime = DateFormat('yyyy/MM/dd(E) HH:mm').format(DateTime.now());
    var cloudtime = DateFormat('yyyy/MM/dd').format(DateTime.now());


    //firestoreに追加
    await FirebaseFirestore.instance.collection('imags').add({
      'title': title,
      'subtitle': subtitle,
      'imgurl': imgurl,
      'count': count,
      'uid': userid,
      'cloudurl': cloudurl,
      'time': posttime,
      'cloudtime': cloudtime,
      'name':myName[0],
      'profurl':myProfile[0],
    });
  }

  // firestoreに追加
  //   await doc.set({
  //     'title': title,
  //     'author': author,
  //     'imgURL': imgURL,
  //   });
  // }

  Future pickImage(context) async {
    //カメラから直どりだけにしたから後でここは変える
    final pickedFile = await picker.pickImage(source: ImageSource.camera); //カメラ
    // final pickedFile =
        // await picker.pickImage(source: ImageSource.gallery); //ギャラリー

    // if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
      notifyListeners();
      // ファイルを選択したら、addImgが起動してアップロード
      addImg();

      // ファイルを選択したら、AddImgPageに遷移
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddImgPage(),
          fullscreenDialog: true,
        ),
      );
    // }
  }
  // Firebaseからデータを取得してくる
  // List<Post> myPost = [];
  // Future<void> getdata() async{
  //   var collection = await FirebaseFirestore.instance.collection('imags').get();
  //   myPost = collection.docs
  //       .map((doc) => Post(
  //         name: doc['title'],
  //         distance:  doc['subtitle'],
  //         imageAsset: doc['imgurl']
  //   )).toList();
  //   print(myPost[0].imageAsset);
  //   // this.draggableItems = draggableItems;
  // }

}

class Post {
  const Post({
    required this.userid,
    required this.distance,
    required this.imageAsset,
  });
  final String userid;
  final String distance;
  final String imageAsset;
}





    // final ImagePicker _picker = ImagePicker();
    // // Pick an image
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // // Capture a photo
    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);