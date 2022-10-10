import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddImgModel extends ChangeNotifier {
  //値が入るまではnullだから、? でnullを許容する形にしてあげる
  String? title;
  String? subtitle;
  File? imageFile;
  bool isLoading = false;
  
  final picker = ImagePicker();

  void startLoading(){
    isLoading = true;
    notifyListeners();
  }

  void endLoading(){
    isLoading = false;
    notifyListeners();
  }


  //firebaseの変更をリッスンしている
  Future <void> addImg() async {
    if (title == null) {
      throw 'タイトルが入力されていません。';
    }

    if (subtitle == null) {
      throw '説明が入力されていません。';
    }

    final doc = FirebaseFirestore.instance.collection('imags').doc();

    // storageにアップロード
    String? imgurl;
    if (imageFile != null){
      // storageにアップロード
      final task = await FirebaseStorage.instance
          .ref('images/${doc.id}')
          .putFile(imageFile!);
      imgurl = await task.ref.getDownloadURL();
    }

    //firestoreに追加
    await FirebaseFirestore.instance.collection('imags').add({
      'title':title,
      'subtitle':subtitle,
      'imgurl':imgurl,
    });
  }

    // firestoreに追加
    //   await doc.set({
    //     'title': title,
    //     'author': author,
    //     'imgURL': imgURL,
    //   });
    // }


  Future pickImage() async {
  //カメラから直どりだけにしたから後でここは変える
  //final pickedFile = await picker.pickImage(source: ImageSource.camera); //ギャラリー
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);  //カメラ

  if (pickedFile != null) {
    imageFile = File(pickedFile.path);
    notifyListeners();
  }
}

}







    // final ImagePicker _picker = ImagePicker();
    // // Pick an image
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // // Capture a photo
    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);