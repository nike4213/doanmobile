import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  final CollectionReference orders = FirebaseFirestore.instance.collection('order');

  Future<void> saveOrderToDatabase(String receipt) async{
    await orders.add({
      'date': DateTime.now(),
      'order':receipt,
    });
  }
  Future<void> saveInfoToDatabase(String info) async{
    await orders.add({
      'date': DateTime.now(),
      'Thong tin':info,
    });
  }

  Future addFoodItem(Map<String,dynamic> userInfoMap, String name) async{
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

}