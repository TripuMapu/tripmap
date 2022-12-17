import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(LineAwesomeIcons.arrow_left),
              color: Color(0xFF6C43BC),
            ),
            title: Text(
              "P r o f i l e",
              style: TextStyle(fontSize: 22, color: Color(0xFF6C43BC)),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(LineAwesomeIcons.cog),
                  color: Color(0xFF6C43BC))
            ],
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 100)),
                Container(
                  transform: Matrix4.translationValues(20.0, 0, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF6C43BC), Color(0xFF72DFC5)])),
                  height: 100,
                  width: 100,
                  child: Center(
                    child: ClipOval(
                        child: Image.asset(
                      'png/gigaChad.jpg',
                      fit: BoxFit.cover,
                      height: 94,
                      width: 94,
                    )),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF6C43BC), Color(0xFF72DFC5)])),
                  transform: Matrix4.translationValues(-4.5, 28, 0),
                  child: Center(
                    child: ClipOval(
                      child: Center(
                          child: Icon(LineAwesomeIcons.camera,
                              color: Colors.white, size: 18)),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    transform: Matrix4.translationValues(0, -20, 0),
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.centerLeft,
                    width: 70,
                    height: 35,
                    child: Text(
                      "Ad Soyad",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.start,
                    )),
                Container(
                    transform: Matrix4.translationValues(0, -25, 0),
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Icon(LineAwesomeIcons.user,
                            size: 18, color: Colors.grey),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Jack Daniel",
                              style: TextStyle(letterSpacing: 1)),
                        ),
                      ],
                    )),
                SizedBox(
                  child: Container(
                    transform: Matrix4.translationValues(0, -25, 0),
                    width: 285,
                    height: 2,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF6C43BC), Color(0xFF72DFC5)])),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 0)),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    alignment: Alignment.centerLeft,
                    width: 100,
                    height: 30,
                    child: Text(
                      "Kullanıcı Adı",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.start,
                    )),
                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Icon(LineAwesomeIcons.at, size: 18, color: Colors.grey),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Jack.Daniel",
                              style: TextStyle(letterSpacing: 1)),
                        ),
                      ],
                    )),
                SizedBox(
                  child: Container(
                    width: 285,
                    height: 2,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF6C43BC), Color(0xFF72DFC5)])),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    alignment: Alignment.centerLeft,
                    width: 100,
                    height: 30,
                    child: Text(
                      "E-mail",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.start,
                    )),
                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Icon(LineAwesomeIcons.at, size: 18, color: Colors.grey),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("trenci_jack@gmail.com",
                              style: TextStyle(letterSpacing: 1)),
                        ),
                      ],
                    )),
                SizedBox(
                  child: Container(
                    width: 285,
                    height: 2,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF6C43BC), Color(0xFF72DFC5)])),
                  ),
                )
              ],
            ),
          )),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Container(
                  transform: Matrix4.translationValues(40, 30, 0),
                  child: Text(
                    "Rotalarım",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(200, 30, 0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Tüm Rotalarım",
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Row(
                children: [
                  Container(
                    transform: Matrix4.translationValues(30, 18, 0),
                    //   color: Colors.black,
                    width: 338,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(108, 67, 188, 1),
                              Color(0xFF72DFC5)
                            ])),
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Container(
                        width: 65,
                        height: 260,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Container(
                              child: Container(
                                transform: Matrix4.translationValues(10, 0, 0),
                                width: 50,
                                height: 50,
                                child: Column(
                                  children: [
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, 8, 0),
                                      child: Text(
                                        "JAN",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, 8, 0),
                                      child: Text(
                                        "27",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color.fromRGBO(108, 67, 188, 1),
                                          Color(0xFF72DFC5)
                                        ]),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Container(
                              width: 255,
                              transform: Matrix4.translationValues(20, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "Galata Kulesi",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Icon(LineAwesomeIcons.arrow_right),
                                  Text(
                                    " ... ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Icon(LineAwesomeIcons.arrow_right),
                                  Text(
                                    "Ayasofya Camii",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                          transform: Matrix4.translationValues(-52, 38, 0),
                          width: 73,
                          height: 30,
                          alignment: Alignment.topCenter,
                          child: Container(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Rotayı Görüntüle",
                                style: TextStyle(
                                    fontSize: 7.5,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF6C43BC)),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Container(
                    transform: Matrix4.translationValues(30, 18, 0),
                    //   color: Colors.black,
                    width: 338,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(108, 67, 188, 1),
                              Color(0xFF72DFC5)
                            ])),
                    child: Padding(
                      padding: EdgeInsets.all(1),
                      child: Container(
                        width: 65,
                        height: 260,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Container(
                              child: Container(
                                transform: Matrix4.translationValues(10, 0, 0),
                                width: 50,
                                height: 50,
                                child: Column(
                                  children: [
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, 8, 0),
                                      child: Text(
                                        "OCT",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                      transform:
                                          Matrix4.translationValues(0, 8, 0),
                                      child: Text(
                                        "23",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color.fromRGBO(108, 67, 188, 1),
                                          Color(0xFF72DFC5)
                                        ]),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Container(
                              width: 255,
                              transform: Matrix4.translationValues(20, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "Taksim Meydanı",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Icon(LineAwesomeIcons.arrow_right),
                                  Text(
                                    " ... ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Icon(LineAwesomeIcons.arrow_right),
                                  Text(
                                    "Kuzguncuk",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                          transform: Matrix4.translationValues(-52, 38, 0),
                          width: 73,
                          height: 30,
                          alignment: Alignment.topCenter,
                          child: Container(
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Rotayı Görüntüle",
                                style: TextStyle(
                                    fontSize: 7.5,
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF6C43BC)),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
