import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/modelo/lista_compra.dart';
import 'package:proyecto_final/pantallas/pagina_principal_llena.dart';
import 'package:proyecto_final/pantallas/pagina_principal_vacia.dart';

import 'lista_compra_anadir_producto.dart';

class PaginaPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:construirPantallaListaCompra(),
      floatingActionButton: FloatingActionButton(
        elevation: 6,
        onPressed: () {
          final manager = Provider.of<ListaCompra>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ListaCompraAnadirProducto(
                  crearProducto:(producto){
                    manager.anadeProducto(producto);
                    Navigator.pop(context);
                  },
                  editarProducto: (producto) { },
                );
              }, ),
          ); },
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget construirPantallaListaCompra(){
    return Consumer<ListaCompra>(
        builder: (context, manager, child){
          if(manager.productos.isNotEmpty){
            return ListaCompraPantallaLlena(listaCompra: manager);
          }else{
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
                const SliverToBoxAdapter(
                    child: pantalla_vacia()
                ),
              ],
            );
          }
        }
    );
  }

}
