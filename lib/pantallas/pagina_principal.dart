import 'package:flutter/material.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No appBar property provided, only the body.
      body: CustomScrollView(
        slivers: [
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            // Provide a standard title.
            title: const Text(
              'Lista de la compra',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
              ),
            ),
            // Allows the user to reveal the app bar if they begin scrolling
            // back up the list of items.
            floating: false,
            // Display a placeholder widget to visualize the shrinking size.
            flexibleSpace: Container(
              color: Colors.indigo,
            ),
            // Make the initial height of the SliverAppBar larger than normal.
            expandedHeight: 150,
          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
                  (context, index) => ListTile(title: Text('Item #$index')),
              // Builds 1000 ListTiles
              childCount: 100,
            ),
          )
        ],
      ),
    );
  }
}
