import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tripmap/screens/loginscreen.dart';
import 'package:tripmap/screens/profilescreenedit.dart';

class ProfileScreen extends StatelessWidget {
  final int currentindex;
  const ProfileScreen({Key? key, required this.currentindex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: currentindex == 4
            ? CustomScrollView(
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Image.asset(
                        'png/DuzLogo.PNG',
                        width: 150,
                      ),
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
                        color: const Color(0xFF6C43BC),
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 135,
                              width: 135,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF6C43BC),
                                    Color(0xFF73DFC5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: ClipOval(
                              child: Image.asset(
                                'png/gigaChad.jpg',
                                fit: BoxFit.cover,
                                height: 127,
                                width: 127,
                              ),
                            ),
                          ),
                          /* Padding(
                            padding: const EdgeInsets.fromLTRB(225, 135, 0, 0),
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF6C43BC),
                                    Color(0xFF73DFC5),
                                  ],
                                ),
                              ),
                              child: ClipOval(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    LineAwesomeIcons.camera,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ), */
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                'Ad Soyad',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                              child: Text(LoginScreen.fullname),
                            ),
                            Container(
                              width: 315,
                              height: 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6C43BC),
                                    Color(0xFF72DFC5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                'Kullanıcı Adı',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                              child: Text(LoginScreen.username),
                            ),
                            Container(
                              width: 315,
                              height: 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6C43BC),
                                    Color(0xFF72DFC5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                'E-Posta',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                              child: Text(LoginScreen.email),
                            ),
                            Container(
                              width: 315,
                              height: 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6C43BC),
                                    Color(0xFF72DFC5),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 45, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Rotalarım'),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Tümünü Gör',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 2,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFF6C43BC),
                                              Color(0xFF72DFC5),
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "OCT",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "23",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 10, 0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 0, 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Galata Kulesi",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Icon(
                                                    LineAwesomeIcons
                                                        .arrow_right,
                                                  ),
                                                  Text(
                                                    " ... ",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Icon(
                                                    LineAwesomeIcons
                                                        .arrow_right,
                                                  ),
                                                  Text(
                                                    "Ayasofya Camii",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: const Text(
                                                    "Rotayı Görüntüle",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: Color(0xFF6C43BC),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              )
            : Container());
  }
}
