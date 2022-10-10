import 'package:cloud_firestore/cloud_firestore.dart';
import '/domain/image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'add_img_model.dart';


class AddImgPage extends StatelessWidget {

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _images = _firestore.collection('imags');
  final Stream<QuerySnapshot> _imagesStream = _images.snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddImgModel>(
      create: (_) => AddImgModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('画像を追加'),
        ),
        body: Center(
          child: Consumer<AddImgModel>(builder: (context, model, child){
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: SizedBox(
                          width: 320,
                          height: 400,
                          child: model.imageFile != null
                          ? Image.file(model.imageFile!)
                          : Container(
                            color: Colors.grey,
                          )
                        ),
                        onTap: () async {
                          await model.pickImage();
                        },
                      ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '写真のタイトル',
                      ),
                      onChanged: (text) {
                        model.title = text;
                      },
                    ),

                  const SizedBox(
                    height: 8,
                  ),
                
                  TextField(
                    decoration: InputDecoration(
                      hintText: '説明欄',
                    ),
                    onChanged: (text) {
                      model.subtitle = text;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(onPressed: () async {
                    //追加の処理
                    try{
                      model.startLoading();
                      await model.addImg();
                      Navigator.of(context).pop(true);
                      //Navigator.pop(context, true);
                      // final snackBar = SnackBar(
                      //   backgroundColor: Colors.green,
                      //   content: Text('景色の追加完了しました。'),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);


                    } catch(err) {
                      //エラーの出力
                      final snackBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(err.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } finally {
                      model.endLoading();
                    }
                  },
                  child: Text('追加する'),
                  ),
                          ],
                        ),
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
      }),
    ),
    
      ),
    );
  }
}