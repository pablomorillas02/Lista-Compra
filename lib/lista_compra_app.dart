import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pantallas/pantallas.dart';
import 'modelo/modelo.dart';

class ListaCompraApp extends StatelessWidget {
  const ListaCompraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de la compra',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ListaCompra(),),
          ],
        child: PaginaPrincipal(),
      ),
    );
  }
}
