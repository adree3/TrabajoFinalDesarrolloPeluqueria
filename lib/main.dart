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
