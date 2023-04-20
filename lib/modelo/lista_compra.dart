import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_final/modelo/producto.dart';

class ListaCompra extends ChangeNotifier {
  final _productos = <Producto>[];
  final _productosCompletados = <Producto>[];
  List<Producto> get productos => List.unmodifiable(_productos);
  List<Producto> get productosCompletados => List.unmodifiable(_productosCompletados);
  void set productos (List<Producto> lista) => productos = lista;

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

    if(await file.length() != 0 && productos.length == 0) {
      final List<String> lineas = await file.readAsLines();
      for (var element in lineas) {
        Producto p = productoDesdeString(element);
        _productos.add(p);
      }
    }

    notifyListeners();
  }

  Producto productoDesdeString(String str) {
    final lista = str.split(';');

    Producto p = Producto(id: lista[0], nombre: lista[1], cantidad: int.parse(lista[2]));

    if(lista[3] == 'true') {
      p.completado = true;
    }

    return p;
  }

  void borraProducto(int indice) {
    Producto producto = _productos[indice];
    borrarLinea(producto);
    _productos.removeAt(indice);
    notifyListeners();
  }

  void borraProductoCompletado(int indice) {
    Producto producto = _productosCompletados[indice];
    //borrarLinea(producto);
    _productosCompletados.removeAt(indice);
    notifyListeners();
  }

  void anadeProducto(Producto item) {
    _productos.add(item);
    escribirLinea(item);
    notifyListeners();
  }

  void actualizaProducto(Producto item, int indice) {
    actualizaLinea(_productos[indice], item);
    _productos[indice] = item;
    notifyListeners();
  }

  void marcaCompletado(int indice, bool completado) {
    Producto? producto = null;

    if(completado){
      producto = _productos[indice];
      _productosCompletados.add(producto.copiaSiNulo(completado: completado));
      _productos.remove(producto);
      //actualizaLinea(producto, _productosCompletados[indice]);
    }else{
      producto = _productosCompletados[indice];
      _productos.add(producto.copiaSiNulo(completado: completado));
      _productosCompletados.remove(producto);
      //actualizaLinea(producto, _productos[indice]);
    }

    actualizaLinea(producto, _productos[indice]);
    notifyListeners();
  }
}