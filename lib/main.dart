import 'dart:io';

import 'package:estructuratrabajofinal/utils/providerTodos.dart';
import 'package:flutter/material.dart';
import 'estructura/p1-IniciarSesion.dart';
import 'bd/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    
    if (Platform.isWindows||Platform.isMacOS){
      databaseFactory = databaseFactoryFfi;
    }else{
      databaseFactory = databaseFactory;
    }
    await DBHelper().eliminarBD();
    print("bd eliminada");
    await DBHelper().openDataBase();
    await initializeDateFormatting('es_ES', null);
    runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderTodos()), 
      ],
      child:MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderTodos>(
      builder: (context, providertodos, child){
        return  MaterialApp(
          theme: ThemeData(
            //primaryColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, 
                shadowColor: Colors.transparent, 
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                textStyle: const TextStyle(fontSize: 20), 
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(
                    color: Colors.white, 
                    width: 0.5,
                  ),
                ),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white), 
              prefixIconColor: Colors.white,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 223, 222, 222)), 
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white), 
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color.fromARGB(255, 59, 40, 11), 
              selectedItemColor: Colors.black, 
              unselectedItemColor: Color(0xff827462), 
            ),
           
          ),
          home: const IniciarSesion(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate, // Agregar esta línea

          ],
          locale: providertodos.idioma,
          supportedLocales: const[
            Locale('es'),
            Locale('en')
          ],
        );
      }
    );
  }
}
