import 'package:flutter/material.dart';
import 'package:barricapp/features/cava/models/wine.dart';
import 'package:barricapp/features/cava/widgets/wine_card.dart';
import 'package:barricapp/core/database/db_helper.dart';

class CavaScreen extends StatefulWidget {
  const CavaScreen({super.key});

  @override
  State<CavaScreen> createState() => _CavaScreenState();
}

class _CavaScreenState extends State<CavaScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    int columns = 1;
    if (screenWidth >= 800) {
      columns = 4;
    } else if (screenWidth >= 600) {
      columns = 3;
    } else if (screenWidth >= 400) {
      columns = 2;
    }

    return FutureBuilder<List<Wine>>(
      future: DatabaseHelper().getWines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'Tu cava está vacía.\n¡Agrega tu primer vino!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final myWines = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: columns == 1 ? 1.5 : 0.75,
            ),
            itemCount: myWines.length,
            itemBuilder: (context, index) {
              return WineCard(
                wine: myWines[index],
                onRefresh: () {
                  setState(() {});
                },
              );
            },
          ),
        );
      },
    );
  }
}