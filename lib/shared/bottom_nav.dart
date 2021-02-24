import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Theme.of(context).accentColor),
            label: 'Home'),
        BottomNavigationBarItem(
            icon:
                Icon(Icons.shopping_cart, color: Theme.of(context).accentColor),
            label: 'Shopping List'),
        BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.barcode,
              color: Theme.of(context).accentColor,
            ),
            label: 'Scan'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank,
              color: Theme.of(context).accentColor,
            ),
            label: 'Fridge'),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle,
                color: Theme.of(context).accentColor),
            label: 'Profile')
      ].toList(),
      fixedColor: Theme.of(context).accentColor,
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nuttin
            break;
          case 1:
            // Navigator.pushNamed(context, '/about');
            break;
          case 2:
            // Navigator.pushNamed(context, '/scanProdukt');
            break;
          case 3:
            Navigator.pushNamed(context, '/fridge');
            break;
          case 4:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
