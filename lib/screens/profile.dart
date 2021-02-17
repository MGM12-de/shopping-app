import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context){
    User user = Provider.of<User>(context);

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? 'Guest'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(user.photoURL != null)
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL)
                  )
                ),
              ),
              Text(user.email ?? '', style: Theme.of(context).textTheme.headline6),
              Spacer(),
              FlatButton(
                child: Text('logout'), 
                color: Colors.red, 
                onPressed: () async {
                  await auth.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
              Spacer()
            ]
          )
        )
      );
    } else {
      return Text('not logged in...');
    }
  }
}