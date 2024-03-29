import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTema {
  static TextTheme temaTextoClaro = TextTheme(
    titleLarge: GoogleFonts.poppins(
      // Lista de la compra
      fontSize: 28.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
    ),
    titleMedium: GoogleFonts.poppins(
      // Añadir/editar
      fontSize: 22.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
    ),
    titleSmall: GoogleFonts.poppins(
      // Nombre del producto
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline,
      color: const Color(0xFF212738),
    ),
    displayLarge: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF212738),
    ),
    displayMedium: GoogleFonts.poppins(
      // TextInput
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF212738),
    ),
    labelMedium: GoogleFonts.poppins(
      // TextInput
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF212738),
      decoration: TextDecoration.lineThrough,
    ),
    labelSmall: GoogleFonts.poppins(
      // DropdownMenu
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
    ),
    displaySmall: GoogleFonts.poppins(
      // P.e ...
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xAA5A5A5A),
    ),
  );

  static TextTheme temaTextoOscuro = TextTheme(
    titleLarge: GoogleFonts.poppins(
      // Lista de la compra
      fontSize: 28.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
    ),
    titleMedium: GoogleFonts.poppins(
      // Añadir/editar
      fontSize: 22.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
    ),
    titleSmall: GoogleFonts.poppins(
      // Nombre del producto
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline,
      color: const Color(0xFFEDF2EF),
    ),
    displayLarge: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
    ),
    displayMedium: GoogleFonts.poppins(
      // TextInput
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
    ),
    labelMedium: GoogleFonts.poppins(
      // TextInput
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
      decoration: TextDecoration.lineThrough,
    ),
    labelSmall: GoogleFonts.poppins(
      // DropdownMenu
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xFFEDF2EF),
    ),
    displaySmall: GoogleFonts.poppins(
      // P.e ...
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: const Color(0xAAD3D3D3),
    ),
  );

  static ThemeData claro() {
    return ThemeData(
        backgroundColor: const Color(0xFFEDF2EF),
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF212738),
        ),
        textTheme: temaTextoClaro,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF212738),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFEDF2EF),
        ),
        disabledColor: Color(0xAA5A5A5A),
        inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: const Color(0xAA5A5A5A),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF212738),
              ),
            )),
        checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all<Color>(Color(0xFF212738)),
            checkColor: MaterialStateProperty.all<Color>(Color(0xFFEDF2EF)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.0),
              side: BorderSide(color: Color(0xFF212738)),
            )),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Color(0xFF212738),
        ));
  }

  static ThemeData oscuro() {
    return ThemeData(
      backgroundColor: const Color(0xFF1B202C),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF212738),
      ),
      textTheme: temaTextoOscuro,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF212738),
          shape: CircleBorder(
              side: BorderSide(color: Color(0xFFEDF2EF), width: 1.0))),
      iconTheme: const IconThemeData(
        color: Color(0xFFEDF2EF),
      ),
      disabledColor: Color(0xAA5A5A5A),
      inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: const Color(0xAAD3D3D3),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFFEDF2EF),
            ),
          )),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(Color(0xFFEDF2EF)),
        checkColor: MaterialStateProperty.all<Color>(Color(0xFF212738)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1.0),
          side: BorderSide(color: Color(0xFFEDF2EF)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xFF212738),
      ),
    );
  }
}
