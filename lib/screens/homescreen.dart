import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tripmap/screens/homescreen2.dart';
import 'package:tripmap/widgets/addbottomnavbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);
  int currentIndex = 0;
  PageController pageController = PageController();
  List<BottomNavigationBarItem> bottomnavbaritems = const [
    BottomNavigationBarItem(
      label: 'AnaSayfa',
      icon: Icon(Icons.home),
      backgroundColor: Color.fromARGB(147, 9, 11, 19),
    ),
    BottomNavigationBarItem(
      label: 'Profil',
      icon: Icon(Icons.man),
      backgroundColor: Color.fromARGB(147, 9, 11, 19),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: AddBottomNavBar()
            .bottomNavigationBar(pageController, currentIndex, (index) {
          setState(
            () {
              currentIndex = index;
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 750),
                curve: Curves.ease,
              );
            },
          );
        }, bottomnavbaritems),
        backgroundColor: Colors.white,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            MyHomePage2(),
            Container(),
          ],
        ),
      ),
    );
  }
}
