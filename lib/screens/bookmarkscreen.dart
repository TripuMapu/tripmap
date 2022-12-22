import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xFF6C43BC), Color(0xFF72DFC5)],
  ).createShader(const Rect.fromLTWH(70.0, 150.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: const EdgeInsets.only(top: 15.0),
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
          SliverToBoxAdapter(
            child: Divider(
              height: 5,
              thickness: 2,
              color: Color(0xFF6C43BC),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 6,
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
                                  child: Image.asset(
                                    "png/ayasofya.jpg",
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              "Fener Rum Lisesi",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.only(left: 100),
                              onPressed: () {},
                              icon: Icon(Icons.bookmark_outline),
                              color: Color(0xFF6C43BC),
                              focusColor: Color(0xFF6C43BC),
                              iconSize: 32.5,
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
