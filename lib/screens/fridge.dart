import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:einkaufsapp/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:einkaufsapp/shared/shared.dart';
import 'package:flutter/material.dart';

class FridgeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    User user = Provider.of<User>(context);
    Document<Fridge> fridgeRef = Document<Fridge>(path: 'fridge', id: user.uid);

    return FutureBuilder(
      future: fridgeRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap){
        Fridge fridge = snap.data;

        if(snap.hasData){
          return Scaffold(
            appBar: AppBar(
              title: Text(fridge.fridgeName),
            ),
            body: Center(
              child: getList(fridge.food),
            ),
            floatingActionButton: FloatingActionButton(
                    onPressed: () async { 
                      Food foodListItem = new Food(name: 'test1', 
                                                    iconID: FontAwesomeIcons.footballBall.codePoint, 
                                                    iconFontFamily: FontAwesomeIcons.footballBall.fontFamily, 
                                                    iconFontPackage: FontAwesomeIcons.footballBall.fontPackage );
                      List<Map> test = new List<Map>();
                      test.add(Food.toMap(foodListItem));
                      fridgeRef.upsert({'food': FieldValue.arrayUnion(test) });
                     },
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

  Widget getList(List<Food> foods){
    print(foods);
    if(foods != null){
      return ListView(
                children: foods.map((e) => FoodItem(food: e)).toList()
              );
    } else {
      return Text("no Data");
    }
  }
}


class FoodItem extends StatelessWidget{
  final Food food;
  const FoodItem({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context){
    IconData icon = new IconData(food.iconID, fontFamily: food.iconFontFamily, fontPackage: food.iconFontPackage); 
    return Container(
      child: Card(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: ListTile(
          title: Text(food.name),
          leading: Icon(icon),
        ),
      ),
    );
  }
}