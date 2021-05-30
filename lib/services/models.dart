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
  final String eco;

  factory ProductScore.fromJson(Map<String, dynamic> json) {
    return ProductScore(
        nutri: json['nutriscore_grade'] ?? 'unknown',
        eco: json['ecoscore_grade'] ?? 'unknown');
  }

  ProductScore({this.nutri, this.eco});
}

class Nutriments {
  final num energy;
  final num energyKcal;
  final num fat;
  final num saturedFat;
  final num carbohydrates;
  final num sugar;
  final num proteins;
  final num salt;

  factory Nutriments.fromJson(Map<String, dynamic> json) {
    return Nutriments(
        energy: json['energy-kj_100g'],
        energyKcal: json['energy-kcal_100g'],
        fat: json['fat_100g'],
        saturedFat: json['saturated-fat_100g'],
        carbohydrates: json['carbohydrates_100g'],
        proteins: json['proteins_100g'],
        salt: json['salt_100g'],
        sugar: json['sugars_100g']);
  }

  Nutriments(
      {this.energy,
      this.energyKcal,
      this.fat,
      this.saturedFat,
      this.carbohydrates,
      this.sugar,
      this.proteins,
      this.salt});
}
