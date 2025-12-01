import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CareCenterInventory {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final List<String> firestoreKeys = [
    'wheelchairs',
    'crutches',
    'walkers',
    'oxygenMachines',
    'hospitalBeds',
  ];

  String itemName(int index) {
    if (index < 0 || index >= firestoreKeys.length) {
      return 'Unknown Item';
    }
    switch (firestoreKeys[index]) {
      case 'wheelchairs':
        return 'Wheelchairs';
      case 'crutches':
        return 'Crutches';
      case 'walkers':
        return 'Walkers';
      case 'oxygenMachines':
        return 'Oxygen Machines';
      case 'hospitalBeds':
        return 'Hospital Beds';
      default:
        return 'Unknown Item';
    }
  }

  Future<int> itemAvailable(int index) async {
    final doc = await db.collection('availability').doc('inventory').get();

    final data = doc.data();
    if (data == null) return 0;

    if (index < 0 || index >= firestoreKeys.length) return 0;

    final key = firestoreKeys[index];
    return data[key] ?? 0;
  }

  Future<void> addItem(int index) async {
    final key = firestoreKeys[index];

    final docRef = db.collection('availability').doc('inventory');

    await db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final currentValue = snapshot.data()?[key] ?? 0;

      transaction.update(docRef, {key: currentValue + 1});
    });
  }

  Future<void> removeItem(int index) async {
    final key = firestoreKeys[index];

    final docRef = db.collection('availability').doc('inventory');

    await db.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final currentValue = snapshot.data()?[key] ?? 0;

      if (currentValue > 0) {
        transaction.update(docRef, {key: currentValue - 1});
      }
    });
  }

  int? itemCount() {
    return firestoreKeys.length;
  }
}
