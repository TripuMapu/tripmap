import 'package:flutter/material.dart';

class AddBottomNavBar {
  BottomNavigationBar bottomNavigationBar(
      PageController pageController,
      int currentIndex,
      Function(int index) function,
      List<BottomNavigationBarItem> bottomnavbaritems) {
    return BottomNavigationBar(
      iconSize: 26,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      showUnselectedLabels: false,
      selectedIconTheme: const IconThemeData(
        color: Color.fromARGB(255, 207, 107, 107),
      ),
      unselectedIconTheme: const IconThemeData(
        color: Color.fromARGB(175, 207, 107, 107),
      ),
      type: BottomNavigationBarType.shifting,
      currentIndex: currentIndex,
      onTap: (index) => function(index),
      items: bottomnavbaritems,
    );
  }
}
