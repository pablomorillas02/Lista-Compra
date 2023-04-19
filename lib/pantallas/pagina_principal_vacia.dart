import 'package:flutter/material.dart';
class pantalla_vacia extends StatelessWidget {
  const pantalla_vacia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Text(
                        'Añade productos pulsando el botón',
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                  )
                ],
              ),
            )
        ),
      ],
    );

  }
}
