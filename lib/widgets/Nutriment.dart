import 'package:einkaufsapp/models/models.dart';
import 'package:flutter/widgets.dart';

class NutrimentWidget extends StatelessWidget {
  const NutrimentWidget({
    Key key,
    @required this.nutriments,
  }) : super(key: key);

  final Nutriments nutriments;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 25),
        child: Table(
          border: TableBorder.symmetric(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(children: <Widget>[
              Text("Energie"),
              Text(nutriments.energy.toString() +
                  " kJ / " +
                  nutriments.energyKcal.toString() +
                  " kcal")
            ]),
            TableRow(children: <Widget>[
              Text("Fett"),
              Text(nutriments.fat.toString() + " g")
            ]),
            TableRow(children: <Widget>[
              Text("- davon gesättigte Fettsäuren"),
              Text(nutriments.saturedFat.toString() + " g")
            ]),
            TableRow(children: <Widget>[
              Text("Kohlenhydrate"),
              Text(nutriments.carbohydrates.toString() + " g")
            ]),
            TableRow(children: <Widget>[
              Text("- davon Zucker"),
              Text(nutriments.sugar.toString() + " g")
            ]),
            TableRow(children: <Widget>[
              Text("Eiweiß"),
              Text(nutriments.proteins.toString() + " g")
            ]),
            TableRow(children: <Widget>[
              Text("Salz"),
              Text(nutriments.salt.toString() + " g")
            ])
          ],
        ));
  }
}
