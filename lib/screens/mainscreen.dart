import 'package:flutter/material.dart';
import 'package:tripmap/screens/homescreen.dart';
import 'package:tripmap/screens/loadingscreen.dart';
import 'package:tripmap/screens/loginscreen.dart';
import 'package:tripmap/screens/mapsample.dart';
import 'package:tripmap/screens/polyline_screen.dart';
import 'package:tripmap/screens/profilescreen.dart';
import 'package:tripmap/screens/searchscreen.dart';
import 'package:tripmap/widgets/addbottomnavbar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  PageController pageController = PageController();
  List<BottomNavigationBarItem> bottomnavbaritems = const [
    BottomNavigationBarItem(
      label: 'Ana Sayfa',
      icon: Icon(
        Icons.home_outlined,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Arama',
      icon: Icon(
        Icons.search_outlined,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Harita',
      icon: Icon(
        Icons.map_outlined,
      ),
    ),
    BottomNavigationBarItem(
      label: 'Profil',
      icon: Icon(
        LineAwesomeIcons.user,
      ),
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
          controller: pageController,
          children: [
            HomeScreen(
              currentindex: currentIndex,
            ),
            SearchScreen(
              currentindex: currentIndex,
            ),
            PolylineScreen(
              currentindex: currentIndex,
            ),
            LoadingScreen.isLogined
                ? ProfileScreen(
                    currentindex: currentIndex,
                  )
                : const LoginScreen()
          ],
        ),
      ),
    );
  }
}