import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CareCenterInventory {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Reads inventory items from Firestore collection 'inventory
  Future<int> walkerFinal() async {
    final snapshot = await db.collection('inventory').get();

    // there is only one document
    final doc = snapshot.docs.first;

    return doc.data()['walkers'] as int;
  }
}
