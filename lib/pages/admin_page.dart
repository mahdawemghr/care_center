import 'package:care_center/pages/admin_notification.dart';
import 'package:flutter/material.dart';
import '../components/care_centare_inventory.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final inventory = CareCenterInventory();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 4.0,
        shadowColor: Colors.black12,
        backgroundColor: colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Admin Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminNotification(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        itemCount: inventory.itemCount(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),

                title: Text(
                  inventory.itemName(index),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: colorScheme.onSurface,
                  ),
                ),

                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: FutureBuilder<int>(
                    future: inventory.itemAvailable(index),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading count...');
                      }

                      if (snapshot.hasError) {
                        return const Text(
                          'Data Error',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }

                      final value = snapshot.data ?? 0;
                      final bool isAvailable = value > 0;

                      return Text(
                        'Current Stock: $value',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isAvailable
                              ? Colors.green[700]
                              : colorScheme.error,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ),

                leading: IconButton(
                  onPressed: () {
                    inventory.removeItem(index);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                  tooltip: 'Remove Item',
                ),

                trailing: IconButton(
                  onPressed: () {
                    inventory.addItem(index);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 28,
                    ),
                  ),
                  tooltip: 'Add Item',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
