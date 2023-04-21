import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pantallas.dart';
import '../modelo/modelo.dart';


class ListaCompraPantallaLlena extends StatelessWidget {
  const ListaCompraPantallaLlena({Key? key, required this.listaCompra})
      : super(key: key);
  final ListaCompra listaCompra;

  @override
  Widget build(BuildContext context) {
    final productos = listaCompra.productos;
    final productosCompletados = listaCompra.productosCompletados;

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
                    listaCompra.borraProducto(index);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('${item.nombre} borrado',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          )),
                    ));
                    return true;
                  } else {
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
                  title: LineaProducto(
                    producto: item,
                    completar: (valor){
                      if(valor != null){
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final itemCompletado = productosCompletados[index];
              return Dismissible(
                key: Key(itemCompletado.id),
                direction: DismissDirection.horizontal,
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    listaCompra.borraProductoCompletado(index);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('${itemCompletado.nombre} borrado')));
                    return true;
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListaCompraAnadirProducto(
                          productoOriginal: itemCompletado,
                          editarProducto: (itemCompletado) {
                            listaCompra.actualizaProducto(itemCompletado, index);
                            Navigator.pop(context);
                          },
                          crearProducto: (itemCompletado) {},
                        ),
                      ),
                    );
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
                  title: LineaProducto(
                    producto: itemCompletado,
                    completar: (valor){
                      if(valor != null){
                        listaCompra.marcaCompletado(index, valor);
                      }
                    },
                  ),
                ),
              );
            },
            childCount: productosCompletados.length,
          ),
        ),
      ],
    );
  }
}
