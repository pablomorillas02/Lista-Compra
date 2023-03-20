import 'package:flutter/material.dart';
import 'package:proyecto_final/modelo/producto.dart';

class ListaCompra extends ChangeNotifier {
  final _productos = <Producto>[];
  List<Producto> get productos => List.unmodifiable(_productos);

  void borraProducto(int indice) {
    _productos.removeAt(indice);
    notifyListeners();
  }

  void anadeProducto(Producto item) {
    _productos.add(item);
    notifyListeners();
  }

  void actualizaProducto(Producto item, int indice) {
    _productos[indice] = item;
    notifyListeners();
  }

  void marcaCompletado(int indice, bool completado) {
    final producto = _productos[indice];
    _productos[indice] = producto.copiaSiNulo(completado: completado);
    notifyListeners();
  }
}