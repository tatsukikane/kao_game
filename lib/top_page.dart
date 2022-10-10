import 'package:firebase_flutter_test/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bottomtab_page/BottomTabPage.dart';
import 'img_list/img_list_page.dart';
import 'login/login_page.dart';
import 'topic_page/topic_page.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.black,
        decoration: const BoxDecoration(
            image: DecorationImage(
          // image: NetworkImage('https://endlesscanvas.com/wp-content/uploads/2021/09/20210817_141551.jpg'),
          image: NetworkImage(
              'https://images.unsplash.com/photo-1485550409059-9afb054cada4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=930&q=80'
              ),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Padding(
                  // padding: const EdgeInsets.only(top:64.0),
                  padding: const EdgeInsets.only(top: 88.0),

                  child: Column(
                    children: [
                      Text(
                        // 'F*c* Up',
                        'KA',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredokaOne(
                            //shadowsIntoLight
                            //permanentMarker
                            //fredokaOne
                            fontSize: 150,
                            fontWeight: FontWeight.bold,
                            // color: Color.fromARGB(255, 224, 140, 5)
                            // color:Colors.blueAccent
                            // color: Color.fromARGB(255, 255, 222, 89)),
                            color: Color.fromARGB(255, 59, 56, 56)),
                      ),
                      SizedBox(
                        width: 0,
                        height: 10,
                      ),
                      Text(
                        // 'F*c* Up',
                        '0',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredokaOne(
                            //shadowsIntoLight
                            //permanentMarker
                            //fredokaOne
                            fontSize: 150,
                            fontWeight: FontWeight.bold,
                            // color: Color.fromARGB(255, 224, 140, 5)
                            // color:Colors.blueAccent
                            // color: Color.fromARGB(255, 255, 222, 89)
                            color: Color.fromARGB(255, 59, 56, 56)),
                      ),
                      Text(
                        // 'F*c* Up',
                        'GAME',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredokaOne(
                          //shadowsIntoLight
                          //permanentMarker
                          //fredokaOne
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          // color: Color.fromARGB(255, 224, 140, 5)
                          // color:Colors.blueAccent
                          // color: Color.fromARGB(255, 255, 222, 89)
                          color: Color.fromARGB(255, 59, 56, 56),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     fixedSize: Size.fromHeight(56),
              //   ),
              //   onPressed: () {
              //     //ボタンを押したときの挙動
              //     Navigator.pushAndRemoveUntil(
              //         context,
              //         MaterialPageRoute(builder: (context) => BottomTabPage()),
              //         (_) => false);
              //   },
              //   child: Text(
              //     'テスト',
              //     style: GoogleFonts.fredokaOne(
              //       fontSize: 30,
              //     ),
              //     // style: TextStyle(
              //     //   fontSize: 30,
              //     // ),
              //   ),
              // ),
              //ログイン
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 222, 89), //ボタンの背景色
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    shadowColor: Colors.black,
                    elevation: 20,
                  ),
                  onPressed: () {
                    //ボタンを押したときの挙動
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //新規登録
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 222, 89), //ボタンの背景色
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    shadowColor: Colors.black,
                    elevation: 20,
                  ),
                  onPressed: () {
                    //ボタンを押したときの挙動
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
