import 'package:flutter/material.dart';
import 'package:practice_projects/pages/card_screen.dart';
import 'package:practice_projects/pages/home_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int index=0;

  List<Widget> screens=[
    HomeScreen(),
    Center(child: Text('Favorite'),),
    CardScreen(),
    Center(child: Text('Profile'),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp),label: 'Card'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile'),
        ],
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.indigoAccent,
          selectedFontSize: 20,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
          setState(() {
            index=value;
          });
          },
        )
    );
  }
}
