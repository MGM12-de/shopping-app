import 'package:einkaufsapp/models/models.dart';

class Global {
  static final String title = 'Einkaufsapp';

  // Data models
  static final Map models = {Fridge: (data) => Fridge.fromMap(data)};
}
