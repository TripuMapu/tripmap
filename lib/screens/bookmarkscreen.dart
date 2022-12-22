import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tripmap/models/location.dart';
import 'package:tripmap/screens/loginscreen.dart';
import 'package:tripmap/services/authservices.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List locationjson = [];
  List<Location> locationlist = [];
  OverlayEntry? entry;
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xFF6C43BC), Color(0xFF72DFC5)],
  ).createShader(const Rect.fromLTWH(70.0, 150.0, 200.0, 70.0));

  void getbookmarks() async {
    await AuthService().getbookmarks(LoginScreen.userid).then((val) async {
      for (int i = 0; i < val.length; i++) {
        await AuthService().getonefromlocations(val[i]).then((val) {
          locationjson.add(val);
        });
      }
      locationlist =
          locationjson.map((json) => Location.fromJson(json)).toList();
    });
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getbookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                "Kaydedilenler",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.normal,
                  // foreground: Paint()..shader = linearGradient,
                  color: Color(0xFF6C43BC),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              height: 5,
              thickness: 2,
              color: Color(0xFF6C43BC),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: locationlist.length,
              ((context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                width: 60,
                                height: 65,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    (locationlist[index].imageurls)[0],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      locationlist[index].name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    padding: const EdgeInsets.only(right: 5),
                                    onPressed: () {},
                                    icon: const Icon(Icons.bookmark),
                                    color: const Color(0xFF6C43BC),
                                    focusColor: const Color(0xFF6C43BC),
                                    iconSize: 32.5,
                                  ),
                                ],
                              ),
                            )
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
      ),
    );
  }
}
