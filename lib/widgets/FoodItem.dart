import 'package:einkaufsapp/models/models.dart';
import 'package:einkaufsapp/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
