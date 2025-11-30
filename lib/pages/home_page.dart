import 'package:flutter/material.dart';
import 'package:care_center/components/care_centare_inventory.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CareCenterInventory data = CareCenterInventory();
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
        title: const Text('Care Center', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(
                  items[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                // leading: Icon(
                //   Icons.medical_services,
                //   color: Theme.of(context).colorScheme.primary,
                // ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_right),
                ),
                subtitle: FutureBuilder<int>(
                  future: data.walkerFinal(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading...');
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    } else {
                      return Text(
                        snapshot.data.toString(),
                        style: const TextStyle(color: Colors.green),
                      );
                    }
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
