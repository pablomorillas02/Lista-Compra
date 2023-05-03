import 'package:flutter/material.dart';

import '../deshacer/undo_manager.dart';

class pantalla_vacia extends StatelessWidget {
  const pantalla_vacia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.undo),
                        onPressed: (UndoManager.instance.isEmpty())
                            ? null
                            : () {
                                UndoManager.instance.undo();
                              },
                      ),
                    ],
                  ),
                ]),
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
