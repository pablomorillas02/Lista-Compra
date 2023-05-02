import 'package:flutter/material.dart';

import '../deshacer/undo_manager.dart';

class pantalla_vacia extends StatelessWidget {
  const pantalla_vacia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Lista de la compra',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(width: 10.0),
                IconButton(
                  icon: (UndoManager.instance.isEmpty() == true)
                      ? Icon(Icons.block)
                      : Icon(Icons.undo),
                  onPressed: () {
                    UndoManager.instance.undo();
                  },
                ),
              ]),
          floating: false,
          flexibleSpace: Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
          expandedHeight: 100,
        ),
        SliverToBoxAdapter(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  'Añade productos pulsando el botón',
                  style: Theme.of(context).textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )),
      ],
    );
  }
}
