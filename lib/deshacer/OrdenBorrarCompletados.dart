import 'undo_manager.dart';
import 'package:proyecto_final/modelo/modelo.dart';
import 'orden.dart';

class OrdenBorrarCompletados implements Orden {
  late ListaCompra receptor;

  Producto? estadoAnterior;
  int index;

  OrdenBorrarCompletados(this.receptor, this.index);

  @override
  void execute() {
    estadoAnterior = receptor.productos[index];
    receptor.borraProducto(index);
    UndoManager.instance.add(orden: this);
  }

  @override
  void undo() {
    receptor.anadeProductosIndex(index, estadoAnterior!);
  }

  @override
  void redo() {
    receptor.borraProducto(index);
  }
}