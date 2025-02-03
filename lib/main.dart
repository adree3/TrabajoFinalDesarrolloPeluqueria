import 'package:flutter/material.dart';
import 'estructura/P1-IniciarSesion.dart';
import 'bd/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:intl/date_symbol_data_local.dart';



void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    await DBHelper().eliminarBD();
    print("bd eliminada");
    await DBHelper().openDataBase();
    await initializeDateFormatting('es_ES', null);
    runApp(const MainApp());
  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Fondo transparente
            shadowColor: Colors.transparent, // Quitar sombra
            foregroundColor: Colors.white, // Color del texto
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            textStyle: const TextStyle(fontSize: 20), // Tamaño del texto
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(
                color: Colors.white, // Borde blanco
                width: 0.5,
              ),
            ),
          ),
        ),

        // 🔹 Estilo global para los TextFormField
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white), // Color del texto del label
          prefixIconColor: Colors.white, // Color del icono
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 223, 222, 222)), // Color cuando no está enfocado
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Color cuando está enfocado
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 214, 208, 199), // Color de fondo
          selectedItemColor: Colors.black, // Color seleccionado
          unselectedItemColor: Color(0xff827462), // Color no seleccionado
        ),
        /*inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 223, 222, 222))
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          prefixIconColor: Colors.white

        )*/
      ),
      home: const IniciarSesion(),
      debugShowCheckedModeBanner: false,
    );
  }
}
