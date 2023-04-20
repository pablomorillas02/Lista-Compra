import 'package:flutter/material.dart';
import 'package:proyecto_final/pantallas/linea_producto.dart';
import '../modelo/modelo.dart';
import 'lista_compra_anadir_producto.dart';

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
          title: const Text(
            'Lista de la compra',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          floating: false,
          flexibleSpace: Container(
            color: Colors.grey,
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('${item.nombre} borrado')));
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
                        Icon(Icons.edit, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('Editar', style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
                        Icon(Icons.delete_forever, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('Borrar', style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
                        Icon(Icons.edit, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('Editar', style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
                        Icon(Icons.delete_forever, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('Borrar', style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
