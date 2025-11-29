import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                subtitle: const Text(
                  'available 2',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
