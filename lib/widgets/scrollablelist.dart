import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ScrollableListWidget extends StatefulWidget {
  const ScrollableListWidget({Key? key}) : super(key: key);

  @override
  State<ScrollableListWidget> createState() => _ScrollableListWidgetState();
}

class _ScrollableListWidgetState extends State<ScrollableListWidget> {
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
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Container(
                  height: 200,
                  color: Color.fromARGB(255, 236, 236, 236),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          height: 175,
                          width: 120,
                          child: Image.asset(
                            'png/ayasofya.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 3),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ayasofya',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: RatingBarIndicator(
                                    rating: 3.5,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 17,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (isBookmarkeds[index]) {
                                          isBookmarkeds[index] = false;
                                        } else {
                                          isBookmarkeds[index] = true;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      isBookmarkeds[index]
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline,
                                      color: Colors.grey,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 13, right: 13),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ],
          );
        });
  }
}
