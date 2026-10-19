class Wine {
  final String nombre;
  final String tipoUva;
  final String anada;
  final double calificacion;
  final String notasDegustacion;
  final String maridaje;

  Wine({
    required this.nombre,
    required this.tipoUva,
    required this.anada,
    required this.calificacion,
    this.notasDegustacion = '',
    this.maridaje = '',
  });
}