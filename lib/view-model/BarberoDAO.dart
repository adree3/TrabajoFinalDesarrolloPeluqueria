import 'package:estructuratrabajofinal/model/Barbero.dart';
import 'package:estructuratrabajofinal/service/bd/db_helper.dart';
import 'package:sqflite/sqflite.dart';

///Clase Barbero con funciones de la bd
class BarberoDao {
  /* AUN NO LA UTILIZO
  Future<void> addBarbero(Barbero barbero) async{
    final database= await DBHelper().openDataBase();
    await database.insert(
      'Barbero', 
      barbero.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    print('Corte de pelo creado');
  }
  */
  ///Obtiene los barberos de la base de datos
  Future<List<Barbero>> getBarberos() async {
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.query('Barbero');
    return List.generate(maps.length, (i) => Barbero.fromMap(maps[i]));
  }
}