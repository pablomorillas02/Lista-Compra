import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_final/modelo/producto.dart';

// RECEPTO (PATRÓN DESHACER)
class ListaCompra extends ChangeNotifier {
  final _productos = <Producto>[];
  List<Producto> get productos => _productos.toList();
  void set productos(List<Producto> lista) => productos = lista;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('ARCHIVO: $path');
    return File('$path/listado.txt');
  }

  Future<void> escribirLinea(Producto producto) async {
    final file = await _localFile;
    await file.create();

    // Leemos las líneas del archivo
    final lineas = await file.readAsLines();

    // Ponemos la nueva línea
    lineas.add(producto.toString());

    // Escribir el archivo
    await file.writeAsString(lineas.join('\n'));
  }

  Future<void> escribirLineaIndex(int index, Producto producto) async {
    final file = await _localFile;
    await file.create();

    // Leemos las líneas del archivo
    final lineas = await file.readAsLines();

    // Ponemos la nueva línea en su lugar correspondiente
    lineas.insert(index, producto.toString());

    // Escribir el archivo
    await file.writeAsString(lineas.join('\n'));
  }

  Future<void> borrarLinea(Producto producto) async {
    final file = await _localFile;

    // Sacamos las líneas del archivo
    final List<String> lineas = await file.readAsLines();
    for (var element in lineas) {
      if (element == producto.toString()) {
        lineas.remove(element); // Borramos la línea
        break;
      }
    }
    await file.writeAsString(lineas.join('\n'));
  }

  Future<void> actualizaLinea(Producto antiguo, Producto nuevo) async {
    final file = await _localFile;

    // Sacamos las líneas del archivo
    final List<String> lineas = await file.readAsLines();
    for (var i = 0; i < lineas.length; i++) {
      if (lineas[i] == antiguo.toString()) {
        lineas[i] = nuevo.toString(); // Borramos la línea
        break;
      }
    }
    await file.writeAsString(lineas.join('\n'));
  }

  Future<void> obtenerProductoFichero() async {
    final file = await _localFile;

    if (await file.length() != 0 && productos.length == 0) {
      final List<String> lineas = await file.readAsLines();
      for (var element in lineas) {
        Producto p = productoDesdeString(element);
        _productos.add(p);
      }
    }

    _productos.sort((a, b) => a.completado == b.completado
        ? 0
        : a.completado
            ? 1
            : -1);

    notifyListeners();
  }

  Producto productoDesdeString(String str) {
    final lista = str.split(';');

    Producto p = Producto(
        id: lista[0],
        nombre: lista[1],
        cantidad: int.parse(lista[2]),
        unidad: lista[3]);

    if (lista[4] == 'true') {
      p.completado = true;
    }

    return p;
  }

  bool hayProductosCompletados() {
    for (var i in productos) {
      if (i.completado) {
        return true;
      }
    }
    return false;
  }

  Future<void> borraProductosCompletados() async {
    for (var i = productos.length - 1; i >= 0; i--) {
      if (productos[i].completado) {
        await borrarLinea(productos[i]);
        _productos.removeAt(i);
      }
    }
    notifyListeners();
  }

  void borraProducto(int indice) {
    Producto producto = _productos[indice];
    _productos.removeAt(indice);
    borrarLinea(producto);
    notifyListeners();
  }

  void anadeProducto(Producto item) {
    _productos.add(item);
    escribirLinea(item);


    _productos.sort((a, b) => a.completado == b.completado
        ? 0 : a.completado ? 1 : -1);

    notifyListeners();
  }

  Future<void> anadeProductosCompletados(List<Producto> lista) async{
      for(var i = lista.length - 1; i >= 0; i--){
        if(lista[i].completado){
          await escribirLinea(lista[i]);
          _productos.add(lista[i]);
        }
      }
      notifyListeners();
  }

  void anadeProductosIndex(int index, Producto item) {
    _productos.insert(index , item);
    escribirLineaIndex(index, item);
    notifyListeners();
  }

  void actualizaProducto(Producto item, int indice) {
    actualizaLinea(_productos[indice], item);
    _productos[indice] = item;
    notifyListeners();
  }

  void marcaCompletado(int indice, bool completado) {
    final producto = _productos[indice];
    _productos[indice] = producto.copiaSiNulo(completado: completado);
    actualizaLinea(producto, _productos[indice]);
    _productos.sort((a, b) => a.completado == b.completado
        ? 0
        : a.completado
            ? 1
            : -1);
    notifyListeners();
  }
}
