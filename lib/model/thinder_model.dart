import 'package:cloud_firestore/cloud_firestore.dart';

class Thinder {
  const Thinder({
    required this.name,
    required this.time,
    required this.imageAsset,
  });
  final String name;
  final String time;
  final String imageAsset;
}