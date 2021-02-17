import 'package:flutter/material.dart';
import '../services/services.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context){

    if (auth.getUser() != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text('Profile'),
        ),
        body: Center(
          child: FlatButton(
            child: Text('logout'), 
          color: Colors.red, 
          onPressed: () async {
            await auth.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          },)
        ),
      );
    } else {
      return Text('not logged in...');
    }
  }
}