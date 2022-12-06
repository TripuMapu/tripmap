import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  List<bool> isBookmarkeds = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(10),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: .55,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              mainAxisExtent: 250,
            ),
            delegate: SliverChildBuilderDelegate(childCount: 10,
                (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed('/content', arguments: []),
                  child: Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 250,
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Colors.black,
                                    Color.fromARGB(124, 0, 0, 0),
                                    Colors.transparent,
                                  ],
                                  stops: [
                                    .35,
                                    .75,
                                    1,
                                  ]).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.asset(
                              'png/ayasofya.jpg',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    '4.5/5',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              color: const Color.fromARGB(113, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'Ayasofya',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (isBookmarkeds[index]) {
                                            isBookmarkeds[index] = false;
                                          } else {
                                            isBookmarkeds[index] = true;
                                          }
                                        });
                                      },
                                      child: Icon(
                                        isBookmarkeds[index]
                                            ? Icons.bookmark
                                            : Icons.bookmark_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
