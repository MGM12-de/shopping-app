import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Shopping List'),
            BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Food'),
            BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: 'Profile')
      ].toList(),
      fixedColor: Colors.deepOrangeAccent,
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nuttin
            break;
          case 1:
            // Navigator.pushNamed(context, '/about');
            break;
          case 2:
            // Navigator.pushNamed(context, '/profile');
            break;
          case 3: 
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}