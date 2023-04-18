import 'package:flutter/material.dart';
import '../modelo/modelo.dart';
import 'package:uuid/uuid.dart';

class ListaCompraAnadirProducto extends StatefulWidget {
  final Function(Producto) crearProducto;
  final Function(Producto) editarProducto;
  final Producto? productoOriginal;
  final bool actualizando;

  const ListaCompraAnadirProducto({
    Key? key,
    required this.crearProducto,
    required this.editarProducto,
    this.productoOriginal,
  }) : actualizando = (productoOriginal != null),
        super(key: key);
  @override
  _ListaCompraAnadirProductoState createState() => _ListaCompraAnadirProductoState();
}

class _ListaCompraAnadirProductoState extends State<ListaCompraAnadirProducto> {

  final _controladorNombre = TextEditingController();
  String _nombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final producto = Producto(
                id: widget.productoOriginal?.id ?? const Uuid().v1(),
                nombre: _controladorNombre.text,
                cantidad: 0,
              );

              if (widget.actualizando) {
                widget.editarProducto(producto);
              } else {
                widget.crearProducto(producto);
              } },
          ), ],
        elevation: 0.0,
        title: const Text( 'Añadir/editar', ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            construyeCampoNombre(),
          ], ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final productoOriginal = widget.productoOriginal;
    if (productoOriginal != null) {
      _controladorNombre.text = productoOriginal.nombre;
      _nombre = productoOriginal.nombre;
    }

    _controladorNombre.addListener(() {
      setState(() { _nombre = _controladorNombre.text; });
    });
  }

  @override
  void dispose() {
    _controladorNombre.dispose();
    super.dispose();
  }

  Widget construyeCampoNombre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nombre del producto:',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextField(
          controller: _controladorNombre,
          decoration: const InputDecoration(
            hintText: 'P.e.: Pan, 1kg de sal, etc.',
          ),
        ), ],
    );
  }

}
