class Producto {
  final String id;
  final String nombre;
  final int cantidad;
  final String unidad;
  late bool completado;

  Producto({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.unidad,
    this.completado = false
  });

  Producto copiaSiNulo({String? id, String? nombre, int? cantidad, String? unidad, bool? completado,}) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      unidad: unidad ?? this.unidad,
      completado: completado ?? this.completado,
    );
  }

  @override
  String toString() {
    return '${id};${nombre};${cantidad};${unidad};${completado}';
  }
}