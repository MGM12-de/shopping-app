import 'package:einkaufsapp/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:einkaufsapp/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FridgeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    User user = Provider.of<User>(context);
    Document<Fridge> fridgeRef = Document<Fridge>(path: 'fridge', id: user.uid);
    
    return FutureBuilder(
      future: fridgeRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap){
        if(snap.hasData){
          return Scaffold(
            appBar: AppBar(
              title: Text('Fridge'),
            ),
            body: Center(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.emoji_food_beverage),
                    title: Text("Tee"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cheese, color: Colors.yellow,),
                    title: Text("Käse")
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.apple, color: Colors.red,),
                    title: Text("Apfel")
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cookie, color: Colors.brown,),
                    title: Text("Kekse"),
                    trailing: Text("5x"),
                    subtitle: Text("ttt"),
                    isThreeLine: true,

                  )
                ],
              )
            ),
            floatingActionButton: FloatingActionButton(
                    onPressed: () async {  },
                    child: Icon(Icons.add),
                    backgroundColor: Theme.of(context).accentColor,
                    
                  ),
          );
        } else {
return LoadingScreen();
        }
      },
    );
  }
}