import 'package:flutter/material.dart';
import 'package:barricapp/features/cava/models/wine.dart';
import 'package:barricapp/features/cava/widgets/wine_card.dart';

class CavaScreen extends StatelessWidget {
  CavaScreen({super.key});

  //Datos de prueba
  final List<Wine> myWines = [
    Wine(
      nombre: 'Trivento Reserve',
      tipoUva: 'Malbec',
      anada: '2022',
      calificacion: 5.0,
    ),
    Wine(
      nombre: 'Casillero del Diablo',
      tipoUva: 'Sauvignon Blanc',
      anada: '2023',
      calificacion: 4.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: myWines.length,
        itemBuilder: (context, index) {
          return WineCard(wine: myWines[index]);
        },
      ),
    );
  }
}
