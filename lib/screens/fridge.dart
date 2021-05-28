import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:einkaufsapp/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:provider/provider.dart';
import 'package:einkaufsapp/shared/shared.dart';
import 'package:flutter/material.dart';

class FridgeScreen extends StatelessWidget {
  Document<Fridge> fridgeRef;
  final foodInputController = TextEditingController();
  IconData _icon;
  Food foodListItem;
  bool isAdaptive = true;
  bool showTooltips = false;
  bool showSearch = true;

  createDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Test Dialog"),
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: foodInputController,
                    decoration: InputDecoration(
                        labelText: "Food", hintText: "Bierkasten"),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(_icon),
                        RaisedButton(
                          onPressed: () => {_pickIcon(context)},
                          child: Text("Select an Icon"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text("Save"),
                onPressed: () {
                  foodListItem = new Food(
                      name: foodInputController.text,
                      iconID: _icon.codePoint,
                      iconFontFamily: _icon.fontFamily,
                      iconFontPackage: _icon.fontPackage);
                  List<Map> test = new List<Map>();
                  test.add(Food.toMap(foodListItem));
                  fridgeRef.upsert({'food': FieldValue.arrayUnion(test)});
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  _pickIcon(BuildContext context) async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconSize: 40,
        iconPickerShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title:
            Text('Pick an icon', style: TextStyle(fontWeight: FontWeight.bold)),
        closeChild: Text(
          'Close',
          textScaleFactor: 1.25,
        ),
        searchHintText: 'Search icon...',
        noResultsText: 'No results for:');
    _icon = icon;
    (context as Element).reassemble(); // refresh screen
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    fridgeRef = Document<Fridge>(path: 'fridge', id: user.uid);

    return FutureBuilder(
      future: fridgeRef.getData(),
      builder: (BuildContext context, AsyncSnapshot snap) {
        Fridge fridge = snap.data;

        if (snap.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(fridge.fridgeName),
              actions: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    fridgeRef.getData();
                  },
                ),
              ],
            ),
            body: Center(
              child: getList(fridge.food),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                createDialog(context);
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

  Widget getList(List<Food> foods) {
    print(foods);
    if (foods != null) {
      return ListView(
          children: foods
              .map((e) => FoodItem(
                    key: Key(e.hashCode.toString()),
                    food: e,
                    fridgeRef: fridgeRef,
                  ))
              .toList());
    } else {
      return Text("no Data");
    }
  }
}

class FoodItem extends StatelessWidget {
  final Food food;
  final Document<Fridge> fridgeRef;
  const FoodItem({Key key, this.food, this.fridgeRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData icon = new IconData(food.iconID,
        fontFamily: food.iconFontFamily, fontPackage: food.iconFontPackage);
    return Container(
      child: Card(
        color: Theme.of(context).accentColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Dismissible(
          key: key,
          onDismissed: (direction) {
            // Todo Delete Entry
            // fridgeRef.ref.update({['food.' + key.toString]: FieldValue.delete()});
          },
          child: ListTile(
            title: Text(food.name),
            leading: Icon(icon),
          ),
        ),
      ),
    );
  }
}
