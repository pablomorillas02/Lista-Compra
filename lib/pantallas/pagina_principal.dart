import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../modelo/modelo.dart';
import 'pantallas.dart';

class PaginaPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<ListaCompra>(context, listen: false);
    manager.obtenerProductoFichero();

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body:
        construirPantallaListaCompra(),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
              Align(
                alignment: Alignment.bottomLeft,
                child:
                  botonBorrar(),
                ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.65,),
            Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    elevation: 6,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ListaCompraAnadirProducto(
                              crearProducto: (producto) {
                                manager.anadeProducto(producto);
                                Navigator.pop(context);
                              },
                              editarProducto: (producto) {},
                            );
                          },
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
          ],
        ),
    );
  }

  Widget construirPantallaListaCompra() {
    return Consumer<ListaCompra>(
        builder: (context, manager, child) {
          if (manager.productos.isNotEmpty) {
            return ListaCompraPantallaLlena(listaCompra: manager);
          } else {
            return pantalla_vacia();
          }
        }
    );
  }

  Widget botonBorrar(){
    return Consumer<ListaCompra>(
        builder: (context, manager, child) {
          if(manager.productos.isNotEmpty && manager.hayProductosCompletados()){
            return FloatingActionButton(
              onPressed: () {
                manager.borraProductosCompletados();
              },
              mini: true,
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            );
          }else{
            return SizedBox();
          }
        }
    );

  }



}
