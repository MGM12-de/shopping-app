
class Fridge {
  String owner;
  String fridgeName;
  bool defaultFridge;
  List<FridgeUser> users;
  String createdBy;

  Fridge({this.owner, this.fridgeName, this.defaultFridge, this.users, this.createdBy});

  factory Fridge.fromMap(Map data){
    return Fridge(
      fridgeName: data['fridgeName'] ?? '',
      owner: data['uid'], 
      defaultFridge: data['defaultFridge'] ?? true,
      users: data['users'],
      createdBy: data['createdBy']
    );
  }
}

class FridgeUser{
  String uid;
  bool isDefaultFridge;
  bool isOwner;

  FridgeUser({this.uid, this.isDefaultFridge, this.isOwner});

  factory FridgeUser.fromMap(Map data){
    return FridgeUser(
      uid: data['uid'],
      isDefaultFridge: data['isDefaultFridge'] ?? true,
      isOwner: data['isOwner'] ?? false
    );
  }
}