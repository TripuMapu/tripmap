import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tripmap/models/location.dart';

class ScrollableListWidget extends StatefulWidget {
  final List<Location> locationslist;
  final int typeid;
  const ScrollableListWidget(
      {Key? key, required this.locationslist, required this.typeid})
      : super(key: key);

  @override
  State<ScrollableListWidget> createState() => _ScrollableListWidgetState();
}

class _ScrollableListWidgetState extends State<ScrollableListWidget> {
  List<Location> typelocationslist = [];
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
  void gettypelocations() {
    for (int i = 0; i < widget.locationslist.length; i++) {
      if (widget.locationslist[i].locationtypeid == widget.typeid) {
        typelocationslist.add(widget.locationslist[i]);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    gettypelocations();
  }

  @override
  Widget build(BuildContext context) {
    return typelocationslist.isEmpty
        ? const Center(
            child: Text('Bu liste boştur'),
          )
        : ListView.builder(
            itemCount: typelocationslist.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                    child: Container(
                      height: 200,
                      color: const Color.fromARGB(255, 236, 236, 236),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 175,
                                width: 120,
                                child: Image.network(
                                  typelocationslist[index].imageurl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(3, 10, 3, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        typelocationslist[index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
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
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: RatingBarIndicator(
                                      rating: typelocationslist[index]
                                          .avaragerating
                                          .toDouble(),
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 17,
                                      direction: Axis.horizontal,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(
                                          typelocationslist[index].defination))
                                ],
                              ),
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
