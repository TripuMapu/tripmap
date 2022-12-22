import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tripmap/screens/profilescreenedit.dart';

class ProfileScreen extends StatelessWidget {
  final int currentindex;
  const ProfileScreen({Key? key, required this.currentindex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return currentindex == 3
        ? Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(LineAwesomeIcons.arrow_left),
                    color: const Color(0xFF6C43BC),
                  ),
                  title: const Text(
                    "P r o f i l",
                    style: TextStyle(fontSize: 22, color: Color(0xFF6C43BC)),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreenEdit(),
                            ),
                          );
                        },
                        icon: const Icon(LineAwesomeIcons.cog),
                        color: const Color(0xFF6C43BC))
                  ],
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 100),
                      ),
                      Container(
                        transform: Matrix4.translationValues(20.0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF6C43BC),
                              Color(0xFF72DFC5),
                            ],
                          ),
                        ),
                        height: 100,
                        width: 100,
                        child: Center(
                          child: ClipOval(
                            child: Image.asset(
                              'png/gigaChad.jpg',
                              fit: BoxFit.cover,
                              height: 94,
                              width: 94,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF6C43BC),
                                  Color(0xFF72DFC5)
                                ])),
                        transform: Matrix4.translationValues(-4.5, 28, 0),
                        child: const Center(
                          child: ClipOval(
                            child: Center(
                                child: Icon(LineAwesomeIcons.camera,
                                    color: Colors.white, size: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            transform: Matrix4.translationValues(0, -20, 0),
                            alignment: Alignment.centerLeft,
                            width: 70,
                            height: 35,
                            child: const Text(
                              "Ad Soyad",
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.start,
                            )),
                        Container(
                          transform: Matrix4.translationValues(0, -25, 0),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              const Icon(LineAwesomeIcons.user,
                                  size: 18, color: Colors.grey),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: const Text(
                                  "Jack Daniel",
                                  style: TextStyle(
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Container(
                            transform: Matrix4.translationValues(0, -25, 0),
                            width: 285,
                            height: 2,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF6C43BC),
                                  Color(0xFF72DFC5),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.centerLeft,
                          width: 100,
                          height: 30,
                          child: const Text(
                            "Kullanıcı Adı",
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Row(
                              children: [
                                const Icon(LineAwesomeIcons.at,
                                    size: 18, color: Colors.grey),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: const Text("Jack.Daniel",
                                      style: TextStyle(letterSpacing: 1)),
                                ),
                              ],
                            )),
                        SizedBox(
                          child: Container(
                            width: 285,
                            height: 2,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF6C43BC),
                                  Color(0xFF72DFC5),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 100,
                          height: 30,
                          child: const Text(
                            "E-mail",
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Row(
                              children: [
                                const Icon(LineAwesomeIcons.at,
                                    size: 18, color: Colors.grey),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: const Text(
                                    "trenci_jack@gmail.com",
                                    style: TextStyle(
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          child: Container(
                            width: 285,
                            height: 2,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF6C43BC),
                                  Color(0xFF72DFC5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Rotalarım",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Tüm Rotalarım",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(childCount: 2,
                        ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF6C43BC),
                            Color(0xFF72DFC5),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "OCT",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        Text("23",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFF6C43BC),
                                          Color(0xFF72DFC5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 10, 0, 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Galata Kulesi",
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              Icon(
                                                  LineAwesomeIcons.arrow_right),
                                              Text(
                                                " ... ",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              Icon(
                                                  LineAwesomeIcons.arrow_right),
                                              Text(
                                                "Ayasofya Camii",
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              //splashFactory: ,
                                              onTap: () {},
                                              child: Text(
                                                "Rotayi Goruntule",
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: const Color(
                                                        0xFF6C43BC)),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  );
                })))
              ],
            ),
          )
        : const Scaffold();
  }
}
