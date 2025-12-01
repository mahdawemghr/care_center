import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CareCenterInventory {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<int> walkerFinal() async {
    final doc = await db.collection('availability').doc('inventory').get();

    return doc.data()?['walkers'] ?? 0;
  }
}

