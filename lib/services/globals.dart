import 'services.dart';

class Global {
  static final String title = 'Einkaufsapp';


  // Data models
  static final Map models = {
    Fridge: (data) => Fridge.fromMap(data)
  };


  // Firestore References 
  static final Collection<Fridge> fridgeRef = Collection<Fridge>(path: 'fridge');
} 