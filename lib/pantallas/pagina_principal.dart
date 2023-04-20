import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/modelo/lista_compra.dart';
import 'package:proyecto_final/modelo/producto.dart';
import 'package:proyecto_final/pantallas/pagina_principal_llena.dart';
import 'package:proyecto_final/pantallas/pagina_principal_vacia.dart';

import 'lista_compra_anadir_producto.dart';

class PaginaPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ListaCompra>(context, listen: false);
    manager.obtenerProductoFichero();

    return Scaffold(

      body:construirPantallaListaCompra(),
      floatingActionButton: FloatingActionButton(
        elevation: 6,
        onPressed: () {
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
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }


  Widget construirPantallaListaCompra(){
    return Consumer<ListaCompra>(
        builder: (context, manager, child){
          if(manager.productos.isNotEmpty || manager.productosCompletados.isNotEmpty){
            return ListaCompraPantallaLlena(listaCompra: manager);
          }else{
            return pantalla_vacia();
          }
        }
    );
  }

}
