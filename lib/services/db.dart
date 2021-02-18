import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:einkaufsapp/services/services.dart';
import 'globals.dart';

class Document<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  final String id;
  DocumentReference ref;

  Document({ this.path, this.id }){
    ref = _db.doc('$path/$id');
  }

  Future<T> getData() {
    return ref.get().then((value) => Global.models[T](value.data()) as T);
  }

  Stream<T> streamData() {
    return ref.snapshots().map((event) => Global.models[T](event.data()) as T);
  }

  Future<void> upsert(Map data){
    return ref.set(Map<String, dynamic>.from(data), SetOptions(merge: true));
  }
}


class Collection<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Collection({ this.path }){
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.get();
    return snapshots.docs.map((doc) => Global.models[T](doc.data()) as T).toList();
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((list) => list.docs.map((doc) => Global.models[T](doc.data()) as T));
  }
}