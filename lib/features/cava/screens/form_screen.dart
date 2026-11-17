import 'package:flutter/material.dart';
import 'package:barricapp/core/database/db_helper.dart';
import 'package:barricapp/features/cava/models/wine.dart';

class NuevaCataScreen extends StatefulWidget {
  final Wine? wineToEdit;

  const NuevaCataScreen({super.key, this.wineToEdit});

  @override
  State<NuevaCataScreen> createState() => _NuevaCataScreenState();
}

class _NuevaCataScreenState extends State<NuevaCataScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _nombreController = TextEditingController();
  final _anadaController = TextEditingController();
  final _notasController = TextEditingController();
  final _maridajeController = TextEditingController();
  
  String _uvaSeleccionada = 'Malbec';
  final List<String> _tiposDeUva = ['Malbec', 'Sauvignon Blanc', 'Cabernet', 'Merlot', 'Syrah'];

  @override
  void initState() {
    super.initState();
    if (widget.wineToEdit != null) {
      _nombreController.text = widget.wineToEdit!.nombre;
      _anadaController.text = widget.wineToEdit!.anada;
      _notasController.text = widget.wineToEdit!.notasDegustacion;
      _maridajeController.text = widget.wineToEdit!.maridaje;
      _uvaSeleccionada = widget.wineToEdit!.tipoUva;
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _anadaController.dispose();
    _notasController.dispose();
    _maridajeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.wineToEdit == null ? 'Nueva Cata' : 'Editar Botella', 
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        'Escanear Etiqueta',
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la Botella',
                  hintText: 'Ej. Trivento Reserve',
                  floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del vino';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<String>(
                      value: _uvaSeleccionada,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Uva',
                        floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                        ),
                      ),
                      items: _tiposDeUva.map((String uva) {
                        return DropdownMenuItem<String>(
                          value: uva,
                          child: Text(uva),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _uvaSeleccionada = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _anadaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Añada',
                        hintText: '2022',
                        floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _notasController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notas de Degustación',
                  hintText: 'Color, aromas, sabores...',
                  alignLabelWithHint: true,
                  floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _maridajeController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Maridaje',
                  hintText: 'Con qué platillo lo acompañaste...',
                  alignLabelWithHint: true,
                  floatingLabelStyle: TextStyle(color: Colors.deepPurple),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final currentWine = Wine(
                      id: widget.wineToEdit?.id, 
                      nombre: _nombreController.text,
                      tipoUva: _uvaSeleccionada,
                      anada: _anadaController.text,
                      calificacion: widget.wineToEdit?.calificacion ?? 5.0,
                      notasDegustacion: _notasController.text,
                      maridaje: _maridajeController.text,
                    );

                    if (widget.wineToEdit == null) {
                      await DatabaseHelper().insertWine(currentWine);
                    } else {
                      await DatabaseHelper().updateWine(currentWine);
                    }

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(widget.wineToEdit == null 
                            ? 'Botella guardada en la cava'
                            : 'Botella actualizada exitosamente'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context, true); 
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'GUARDAR REGISTRO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}