import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../deshacer/orden_borrar.dart';
import '../deshacer/undo_manager.dart';
import 'pantallas.dart';
import '../modelo/modelo.dart';

class ListaCompraPantallaLlena extends StatelessWidget {
  const ListaCompraPantallaLlena({Key? key, required this.listaCompra})
      : super(key: key);
  final ListaCompra listaCompra;

  @override
  Widget build(BuildContext context) {
    final productos = listaCompra.productos;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            'Lista de la compra',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          floating: false,
          flexibleSpace: Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.undo),
                        onPressed: (UndoManager.instance.isEmpty())
                            ? null
                            : () {
                                UndoManager.instance.undo();
                              },
                      ),
                    ],
                  ),
                ]),
          ),
          expandedHeight: 100,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = productos[index];
              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.horizontal,
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    OrdenBorrar(listaCompra, index).execute();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${item.nombre} borrado',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          )),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'DESHACER',
                        onPressed: () {
                          UndoManager.instance.undo();
                        },
                      ),
                    ));
                    return true;
                  } else {
                    anadirProducto(context, item, index);
                  }
                  return false;
                },
                background: Container(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.edit, color: Colors.white),
                        const SizedBox(width: 8.0),
                        Text('Editar',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                            )),
                      ],
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Borrar',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                            )),
                        const SizedBox(width: 8.0),
                        const Icon(Icons.delete_forever, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    bool valor = (item.completado == true) ? false : true;
                    listaCompra.marcaCompletado(index, valor);
                  },
                  onLongPress: () {
                    anadirProducto(context, item, index);
                  },
                  title: LineaProducto(
                    producto: item,
                    completar: (valor) {
                      if (valor != null) {
                        listaCompra.marcaCompletado(index, valor);
                      }
                    },
                  ),
                ),
              );
            },
            childCount: productos.length,
          ),
        ),
      ],
    );
  }

  void anadirProducto(BuildContext context, Producto item, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListaCompraAnadirProducto(
          productoOriginal: item,
          editarProducto: (item) {
            listaCompra.actualizaProducto(item, index);
            Navigator.pop(context);
          },
          crearProducto: (item) {},
        ),
      ),
    );
  }
}
