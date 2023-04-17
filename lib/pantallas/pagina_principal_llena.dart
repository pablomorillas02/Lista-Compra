
import 'package:flutter/material.dart';
import '../modelo/modelo.dart';

class ListaCompraPantallaLlena extends StatelessWidget {

  const ListaCompraPantallaLlena({Key? key, required this.listaCompra}) : super(key:
  key);
  final ListaCompra listaCompra;

  @override
  Widget build(BuildContext context) {
    final productos = listaCompra.productos;

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
            color: Colors.indigo,
          ),
          expandedHeight: 100,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context,index) {
            final item = productos[index];
            return Dismissible(
              key: Key(item.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                listaCompra.borraProducto(index);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item borrado')));
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 35.0
                ), ),
              child: ListTile(
                title: Text(item.nombre),
              ),
            );
          },
            childCount: productos.length,
          ),
        )
      ],
    );
  }
}
