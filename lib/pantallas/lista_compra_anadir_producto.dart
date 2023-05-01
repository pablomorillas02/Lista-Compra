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
  })  : actualizando = (productoOriginal != null),
        super(key: key);
  @override
  _ListaCompraAnadirProductoState createState() =>
      _ListaCompraAnadirProductoState();
}

class _ListaCompraAnadirProductoState extends State<ListaCompraAnadirProducto> {
  final _controladorNombre = TextEditingController();
  final _controladorCantidad = TextEditingController();
  final _controladorUnidad = TextEditingController();

  String _nombre = '';
  String _cantidad = '';
  String _unidad = '';

  var _dropdownValue = 'ud';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              final producto = Producto(
                id: widget.productoOriginal?.id ?? const Uuid().v1(),
                nombre: _controladorNombre.text,
                cantidad: int.parse(_controladorCantidad.text),
                unidad: _controladorUnidad.text,
              );

              if (widget.actualizando) {
                widget.editarProducto(producto);
              } else {
                widget.crearProducto(producto);
              }

            },
          ),
        ],
        elevation: 0.0,
        title: Text(
          'Añadir/editar',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            construyeCampos(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final productoOriginal = widget.productoOriginal;
    if (productoOriginal != null) {
      _controladorNombre.text = productoOriginal.nombre;
      _controladorCantidad.text = productoOriginal.cantidad.toString();
      _controladorUnidad.text = productoOriginal.unidad;

      _nombre = productoOriginal.nombre;
      _cantidad = productoOriginal.cantidad.toString();
      _unidad = productoOriginal.unidad;
    }

    _controladorNombre.addListener(() {
      setState(() {
        _nombre = _controladorNombre.text;
      });
    });

    _controladorCantidad.addListener(() {
      setState(() {
        _cantidad = _controladorCantidad.text;
      });
    });

    _controladorUnidad.addListener(() {
      setState(() {
        _unidad = _controladorUnidad.text;
      });
    });
  }

  @override
  void dispose() {
    _controladorNombre.dispose();
    _controladorCantidad.dispose();
    _controladorUnidad.dispose();
    super.dispose();
  }

  Widget construyeCampos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nombre del producto:',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextField(
          controller: _controladorNombre,
          style: Theme.of(context).textTheme.displayMedium,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'P.e.: Pan, 1kg de sal, etc.',
            suffixStyle: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        const SizedBox(height: 12.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Cantidad:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 150.0, // Establece el ancho deseado del Container
              height: 50.0, // Establece la altura deseada del Container
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controladorCantidad,
                style: Theme.of(context).textTheme.displayMedium,
                decoration: InputDecoration(
                  hintText: 'Cantidad',
                  suffixStyle: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            Container(
              width: 150.0, // Establece el ancho deseado del Container
              height: 50.0, // Establece la altura deseada del Container
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).appBarTheme.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'ud',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    value: 'ud',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'kg',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    value: 'kg',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'gr',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    value: 'gr',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'L',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    value: 'L',
                  ),
                ],
                hint: Text(
                  'Unidad',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                value: _dropdownValue,
                isExpanded: true,
                dropdownColor: Theme.of(context).appBarTheme.backgroundColor,
                onChanged: (Object? selectedValue) {
                  if (selectedValue is String) {
                    setState(() {
                      _dropdownValue = selectedValue;
                      _controladorUnidad.text = selectedValue;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
