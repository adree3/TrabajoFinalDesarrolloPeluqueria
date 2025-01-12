import 'package:flutter/material.dart';
import 'estructura/P1-IniciarSesion.dart';
import 'bd/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await DBHelper().eliminarBD();
  print("bd eliminada");

  await DBHelper().openDataBase();
  runApp( const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IniciarSesion()
    );
  }
}
