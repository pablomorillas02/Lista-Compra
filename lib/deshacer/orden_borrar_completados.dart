import 'undo_manager.dart';
import 'package:proyecto_final/modelo/modelo.dart';
import 'orden.dart';

class OrdenBorrarCompletados implements Orden {
  late ListaCompra receptor;

  List<Producto>? estadoAnterior;

  OrdenBorrarCompletados(this.receptor);

  @override
  void execute() {
    estadoAnterior = receptor.productos;
    receptor.borraProductosCompletados();
    UndoManager.instance.add(orden: this);
  }

  @override
  void undo() {
    receptor.anadeProductosCompletados(estadoAnterior!);
  }

  @override
  void redo() {
    receptor.borraProductosCompletados();
  }
}
