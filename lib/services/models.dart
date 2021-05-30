class Fridge {
  String owner;
  String fridgeName;
  bool defaultFridge;
  List<FridgeUser> users;
  String createdBy;
  List<Food> food;

  Fridge(
      {this.owner,
      this.fridgeName,
      this.defaultFridge,
      this.users,
      this.createdBy,
      this.food});

  factory Fridge.fromMap(Map data) {
    return Fridge(
        fridgeName: data['fridgeName'] ?? 'Fridge',
        owner: data['uid'],
        defaultFridge: data['defaultFridge'] ?? true,
        users: data['users'],
        createdBy: data['createdBy'],
        food:
            (data['food'] as List ?? []).map((v) => Food.fromMap(v)).toList());
  }
}

class Food {
  String name;
  int iconID;
  String iconFontFamily;
  String iconFontPackage;
  String iconColor;

  Food(
      {this.name,
      this.iconID,
      this.iconFontFamily,
      this.iconFontPackage,
      this.iconColor});

  factory Food.fromMap(Map data) {
    return Food(
        name: data['name'] ?? 'Food',
        iconID: data['iconID'],
        iconFontFamily: data['iconFontFamily'],
        iconFontPackage: data['iconFontPackage'],
        iconColor: data['iconColor'] ?? 'red');
  }

  static Map toMap(Food data) {
    return {
      'name': data.name,
      'iconColor': data.iconColor,
      'iconID': data.iconID,
      'iconFontPackage': data.iconFontPackage,
      'iconFontFamily': data.iconFontFamily
    };
  }
}

class FridgeUser {
  String uid;
  bool isDefaultFridge;
  bool isOwner;

  FridgeUser({this.uid, this.isDefaultFridge, this.isOwner});

  factory FridgeUser.fromMap(Map data) {
    return FridgeUser(
        uid: data['uid'],
        isDefaultFridge: data['isDefaultFridge'] ?? true,
        isOwner: data['isOwner'] ?? false);
  }
}

class ProductScore {
  final String nutri;

  ProductScore({this.nutri});
}
