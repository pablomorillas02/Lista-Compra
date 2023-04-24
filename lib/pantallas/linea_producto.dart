import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../modelo/modelo.dart';

class LineaProducto extends StatelessWidget {
  final Producto producto;
  final TextDecoration textDecoration;
  final Function(bool) completar;

  LineaProducto({Key? key, required this.producto, required this.completar})
      : textDecoration = producto.completado
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.displayMedium;
    var finalTextStyle = textStyle?.copyWith(decoration: textDecoration);

    return Container(
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    producto.nombre,
                    style: finalTextStyle,
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                producto.cantidad.toString(),
                style: finalTextStyle,
              ),
              const SizedBox(
                width: 4.0,
              ),
              Text(
                producto.unidad,
                style: finalTextStyle,
              ),
              SizedBox(width: 16.0),
              MSHCheckbox(
                size: 30,
                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                  checkedColor: Colors.blue,
                ),
                style: MSHCheckboxStyle.fillScaleCheck,
                value: producto.completado,
                onChanged: completar,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
