class Wine {
  final int? id;
  final String nombre;
  final String tipoUva;
  final String anada;
  final double calificacion;
  final String notasDegustacion;
  final String maridaje;

  Wine({
    this.id,
    required this.nombre,
    required this.tipoUva,
    required this.anada,
    required this.calificacion,
    this.notasDegustacion = '',
    this.maridaje = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo_uva': tipoUva,
      'anada': anada,
      'calificacion': calificacion,
      'notas_degustacion': notasDegustacion,
      'maridaje': maridaje,
    };
  }

  factory Wine.fromMap(Map<String, dynamic> map) {
    return Wine(
      id: map['id'] as int?,
      nombre: map['nombre'] as String,
      tipoUva: map['tipo_uva'] as String,
      anada: map['anada'] as String,
      calificacion: map['calificacion'] as double,
      notasDegustacion: map['notas_degustacion'] as String? ?? '',
      maridaje: map['maridaje'] as String? ?? '',
    );
  }
}