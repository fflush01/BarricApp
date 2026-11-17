import 'package:flutter/material.dart';
import 'package:barricapp/features/cava/models/wine.dart';
import 'package:barricapp/core/database/db_helper.dart';
import 'package:barricapp/features/cava/screens/form_screen.dart';

class CataDetailScreen extends StatelessWidget {
  final Wine wine;

  const CataDetailScreen({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    final bool isRedWine = wine.tipoUva.toLowerCase() == 'malbec';
    final Color headerColor = isRedWine ? const Color(0xFF800020) : Colors.amber.shade100;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: headerColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NuevaCataScreen(wineToEdit: wine),
                ),
              );
              
              if (result == true) {
                if (context.mounted) {
                  Navigator.pop(context, true); 
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: const Text('Eliminar botella'),
                    content: Text('¿Estás seguro de que deseas eliminar ${wine.nombre} de tu cava?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await DatabaseHelper().deleteWine(wine.id!);
                          if (context.mounted) {
                            Navigator.pop(ctx);
                            Navigator.pop(context, true);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Botella eliminada de la cava'), 
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: const Text('Eliminar', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: const Center(
                child: Icon(Icons.wine_bar, color: Colors.white, size: 80),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wine.nombre,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${wine.tipoUva} • ${wine.anada}',
                    style: const TextStyle(
                      fontSize: 16, 
                      color: Colors.deepPurple, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      ...List.generate(5, (index) => Icon(
                        index < wine.calificacion.floor() ? Icons.star : Icons.star_border,
                        color: Colors.amber, 
                        size: 20,
                      )),
                      const SizedBox(width: 8),
                      Text(
                        '${wine.calificacion} / 5', 
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),

                  const Text(
                    'Notas de Degustación', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    wine.notasDegustacion.isNotEmpty 
                        ? wine.notasDegustacion 
                        : 'Sin notas registradas.', 
                    style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  const Text(
                    'Maridaje', 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    wine.maridaje.isNotEmpty 
                        ? wine.maridaje 
                        : 'Sin maridaje registrado.', 
                    style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}