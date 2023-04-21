class Producto {
  final String id;
  final String nombre;
  final int cantidad;
  late bool completado;

  Producto({
    required this.id,
    required this.nombre,
    required this.cantidad,
    this.completado = false
  });

  Producto copiaSiNulo({String? id, String? nombre, int? cantidad, bool? completado,}) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      completado: completado ?? this.completado,
    );
  }

  @override
  String toString() {
    return '${id};${nombre};${cantidad};${completado}';
  }
}