import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:tripmap/models/location.dart';
import 'package:tripmap/models/triproute.dart';
import 'package:tripmap/screens/loadingscreen.dart';
import 'package:tripmap/screens/loginscreen.dart';
import 'package:tripmap/screens/profilescreenedit.dart';
import 'package:tripmap/services/authservices.dart';

class ProfileScreen extends StatefulWidget {
  final int currentindex;
  const ProfileScreen({Key? key, required this.currentindex}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<TripRoute> routelist = [];
  List<String> daystring = [];
  List<String> monthstring = [];
  List locationjson = [];
  List<Location> locationlist = [];
  OverlayEntry? entry;
  late TextEditingController commentController;

  void getroutes() async {
    await AuthService().getroutes(LoginScreen.userid).then((val) async {
      routelist = val.map((json) => TripRoute.fromJson(json)).toList();

      for (int i = 0; i < routelist.length; i++) {
        await AuthService()
            .getlocationidfromname(routelist[i].routelocationname)
            .then((val) async {
          await AuthService().getonefromlocations(val).then((val) {
            locationjson.add(val);
          });
        });

        daystring.add((routelist[i].date.split('.'))[0]);
        switch ((routelist[i].date.split('.'))[1]) {
          case '1':
            monthstring.add('OCA');
            break;
          case '2':
            monthstring.add('ŞUB');
            break;
          case '3':
            monthstring.add('MAR');
            break;
          case '4':
            monthstring.add('NİS');
            break;
          case '5':
            monthstring.add('MAY');
            break;
          case '6':
            monthstring.add('HAZ');
            break;
          case '7':
            monthstring.add('TEM');
            break;
          case '8':
            monthstring.add('AĞU');
            break;
          case '9':
            monthstring.add('EYL');
            break;
          case '10':
            monthstring.add('EKİ');
            break;
          case '11':
            monthstring.add('KAS');
            break;
          case '12':
            monthstring.add('ARA');
            break;
        }
      }
    });
    setState(() {
      locationlist =
          locationjson.map((json) => Location.fromJson(json)).toList();
      hideLoadingOverlay();
    });
  }

  void makecomment(int locationid, String content) async {
    await AuthService()
        .makecomment(LoginScreen.userid, locationid, content, 4.5);

    setState(() {
      hideLoadingOverlay();
    });
  }

  void showLoadingOverlay() {
    final overlay = Overlay.of(context)!;

    entry = OverlayEntry(
      builder: (context) => buildLoadingOverlay(),
    );

    overlay.insert(entry!);
  }

  void hideLoadingOverlay() {
    entry!.remove();
    entry = null;
  }

  Widget buildLoadingOverlay() => const Material(
        color: Colors.transparent,
        elevation: 8,
        child: Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(255, 163, 171, 192)),
        ),
      );

  @override
  void initState() {
    if (widget.currentindex == 3 && LoadingScreen.isLogined) {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
      commentController = TextEditingController();
      getroutes();
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: widget.currentindex == 3
            ? LoadingScreen.isLogined
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
                                  builder: (context) =>
                                      const ProfileScreenEdit(),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 0, 5),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 0, 5),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 10, 0, 5),
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
                              const Text('Önceki Ziyaretlerim'),
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
                          childCount: routelist.length,
                          ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/content',
                                      arguments: [locationlist[index]]);
                                },
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
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
                                                    monthstring[index],
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Text(
                                                    daystring[index],
                                                    style: const TextStyle(
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 10, 0, 8),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          routelist[index]
                                                              .routelocationname,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        /* Icon(
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
                                                        ), */
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          openDialog(
                                                              locationlist[
                                                                      index]
                                                                  .id);
                                                        },
                                                        child: const Text(
                                                          "Yorum Yap",
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            color: Color(
                                                                0xFF6C43BC),
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
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Giriş Yapmalısın'),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/login', arguments: []);
                            },
                            child: const Text('GirişYap')),
                      ],
                    ),
                  )
            : Container());
  }

  Future openDialog(int locationid) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Yorum Yap'),
            content: TextField(
              controller: commentController,
              maxLength: 150,
              maxLines: 6,
              decoration:
                  const InputDecoration(hintText: 'Yorumun', hintMaxLines: 5),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    commentController.clear();
                  },
                  child: const Text('İptal Et')),
              TextButton(
                  onPressed: () {
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => showLoadingOverlay());
                    makecomment(locationid, commentController.text);
                    Navigator.of(context).pop();
                    commentController.clear();
                  },
                  child: const Text('Gönder'))
            ],
          ));
}
