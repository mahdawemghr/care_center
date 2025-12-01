import 'package:flutter/material.dart';
import '../components/care_centare_inventory.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inventory = CareCenterInventory();
    List<String> items = [
      'Wheelchairs',
      'Crutches',
      'Walkers',
      'Oxygen Machines',
      'Hospital Beds',
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Care Center "admin"', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(items[index]),
                leading: Icon(
                  Icons.medical_services,
                  color: Theme.of(context).colorScheme.primary,
                ),
                trailing: IconButton(
                  onPressed: () {
                    inventory.walkerFinal().then((value) {
                      print(value);
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: FutureBuilder<int>(
                  future: inventory.walkerFinal(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                        'Loading...',
                        style: TextStyle(color: Colors.green),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Text(
                        'Error',
                        style: TextStyle(color: Colors.red),
                      );
                    }

                    return Text(
                      snapshot.data.toString(),
                      style: const TextStyle(color: Colors.green),
                    );
                  },
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}
