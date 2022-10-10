import 'package:firebase_core/firebase_core.dart';
import 'top_page.dart';
import 'package:flutter/material.dart';


import 'firebase_options.dart';
import 'img_list/img_list_page.dart';


void main() async {
  //フレームワークとFlutterエンジンを結びつける接着剤のような役割をする
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //利用しているプラットフォームを認識して、対応してくれる
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KAOgame',
      home: TopPage(),
    );
  }
}



//enumを使用することで関連する定数をワンセットで定義
//スワイプした際の三択を定義 ティンダー画面用
//ここは二択に変えるかも？？
enum Swipe { left, right, none }
