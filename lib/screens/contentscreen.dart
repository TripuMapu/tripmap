import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripmap/models/comment.dart';
import 'package:tripmap/screens/loginscreen.dart';
import '../services/authservices.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({Key? key}) : super(key: key);

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  OverlayEntry? entry;
  int activeIndex = 0;
  List commentJson = [];
  List<Comment> commentList = [];
  final urlImages = [
    'png/ayasofya.jpg',
    'png/ayasofya1.jpg',
    'png/ayasofya2.jpg',
    'png/ayasofya3.jpg',
    'png/ayasofya4.jpg'
  ];
  bool isBookmarked = false;

  void getComments() async {
    await AuthService().getlocationcomments(1).then(
      (value) {
        commentJson = value;
        setState(() {
          commentList =
              commentJson.map((json) => Comment.fromJson(json)).toList();
          hideLoadingOverlay();
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => showLoadingOverlay());
    getComments();
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
              height: 450,
              color: Colors.white,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final urlImage = urlImages[index];
                      return buildImage(urlImage, index);
                    },
                    options: CarouselOptions(
                        height: 450,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 10),
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: buildIndicator(),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back),
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
                                setState(
                                  () {
                                    if (isBookmarked == false) {
                                      isBookmarked = true;
                                    } else {
                                      isBookmarked = false;
                                    }
                                  },
                                );
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
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Ayasofya, eski adıyla Kutsal Bilgelik Kilisesi ve Ayasofya Müzesi veya günümüzdeki resmî adıyla Ayasofya-i Kebîr Câmi-i Şerîfi, İstanbul'da yer alan bir cami ve eski bazilika, katedral ve müzedir.",
                style: TextStyle(fontSize: 18),
              ), //Databaseden yazı gelecek.
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: commentList.length,
                (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
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
                                rating: commentList[index].rating,
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
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(commentList[index].content),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Image.asset(
        urlImage,
        fit: BoxFit.cover,
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: const ScrollingDotsEffect(
          dotColor: Color.fromARGB(131, 255, 255, 255),
          activeDotColor: Colors.white,
          dotWidth: 10.0,
          dotHeight: 10.0,
          spacing: 4.0,
        ),
        onDotClicked: (index) {},
      );
}
