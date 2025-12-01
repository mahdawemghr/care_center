import 'package:flutter/material.dart';
import 'package:care_center/components/care_centare_inventory.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _expandedIndex;

  final List<String> items = [
    'Wheelchairs',
    'Crutches',
    'Walkers',
    'Oxygen Machines',
    'Hospital Beds',
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final CareCenterInventory data = CareCenterInventory();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 4.0,
        shadowColor: Colors.black12,
        title: const Text(
          'Care Center Inventory',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: colorScheme.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final bool isExpanded = index == _expandedIndex;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    onTap: () {
                      setState(() {
                        _expandedIndex = isExpanded ? null : index;
                      });
                    },
                    title: Text(
                      items[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(
                        Icons.medical_services,
                        color: colorScheme.primary,
                        size: 28,
                      ),
                    ),
                    trailing: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.arrow_forward_ios,
                      color: colorScheme.onSurfaceVariant,
                      size: 18,
                    ),
                    subtitle: FutureBuilder<int>(
                      future: data.itemAvailable(index),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Checking availability...');
                        }

                        if (snapshot.hasError) {
                          return const Text(
                            'Error fetching data',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }

                        final value = snapshot.data ?? 0;

                        if (value > 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Available: $value',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Currently Not Available',
                              style: TextStyle(
                                color: colorScheme.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Divider(height: 1, thickness: 1),
                          const SizedBox(height: 10),

                          Text(
                            'Details for ${items[index]} can be found here.',
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    print('Show More for ${items[index]}');
                                  },
                                  icon: const Icon(Icons.info_outline),
                                  label: const Text('Show More'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    print('Requesting ${items[index]}');
                                  },
                                  icon: const Icon(Icons.send),
                                  label: const Text('Request Item'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.secondary,
                                    foregroundColor: colorScheme.onSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
