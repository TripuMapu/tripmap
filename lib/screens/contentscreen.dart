import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                height: 35,
                width: 125,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6C43BC),
                      Color(0xFF72DFC5),
                    ],
                    stops: [
                      0.2,
                      1.0,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'GİT',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: VerticalDivider(
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                height: 35,
                width: 125,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF6C43BC),
                      Color(0xFF72DFC5),
                    ],
                    stops: [
                      0.2,
                      1.0,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'ROTAYA EKLE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 500,
              color: Colors.red,
              child: Stack(
                children: [
                  Image.asset('png/ayasofya.jpg',
                      height: 500, fit: BoxFit.fitHeight),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            //navigate to homepage
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back),
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        color: const Color.fromARGB(169, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    'Ayasofya Camii',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isBookmarked == false) {
                                    isBookmarked = true;
                                  } else {
                                    isBookmarked = false;
                                  }
                                });
                              },
                              icon: Icon(
                                isBookmarked
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            sliver: SliverToBoxAdapter(
              child: RatingBarIndicator(
                rating: 3.5,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Ayasofya, eski adıyla Kutsal Bilgelik Kilisesi ve Ayasofya Müzesi veya günümüzdeki resmî adıyla Ayasofya-i Kebîr Câmi-i Şerîfi, İstanbul'da yer alan bir cami ve eski bazilika, katedral ve müzedir.",
                style: TextStyle(fontSize: 18),
              ), //Databaseden yazı gelecek.
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate(childCount: 3, (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 40,
                            width: 40,
                            child: Image.asset(
                              'png/ayasofya.jpg',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            children: [
                              const Text(
                                'Jack.Daniel',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              RatingBarIndicator(
                                rating: 5.0,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 14.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                          'Bu hayatta ne olursan ol, iki karış mermere 4 satır yazı olma.'),
                    ),
                    const Divider(
                      //List length-1 çizgi atılacak
                      thickness: 1,
                    )
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
