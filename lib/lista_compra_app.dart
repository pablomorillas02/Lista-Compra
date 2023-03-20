import 'package:flutter/material.dart';
import 'package:proyecto_final/pantallas/pagina_principal.dart';

class ListaCompraApp extends StatelessWidget {
  const ListaCompraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de la compra',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const PaginaPrincipal(),
    );
  }
}
