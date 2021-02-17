
class Fridge {
  String owner;
  String fridgeName;

  Fridge({this.owner, this.fridgeName});

  factory Fridge.fromMap(Map data){
    return Fridge(
      fridgeName: data['fridgeName'] ?? '',
      owner: data['uid']
    );
  }
}