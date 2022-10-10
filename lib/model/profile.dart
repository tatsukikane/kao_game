//プロフィールカードに必要な情報をすべて保持するモデルクラス
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  const Profile({
    required this.name,
    required this.distance,
    required this.imageAsset,
  });
  final String name;
  final String distance;
  final String imageAsset;
}

// class Profile {
//   const Profile({
//     required this.id,
//     required this.title,
//     required this.imgurl,
//     required this.subtitle,

//   });
//   final String id;
//   final String title;
//   final String imgurl;
//   final String subtitle;
// }