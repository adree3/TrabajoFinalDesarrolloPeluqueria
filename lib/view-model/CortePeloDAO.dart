import 'package:estructuratrabajofinal/model/CortesPelo.dart';
import 'package:estructuratrabajofinal/service/bd/db_helper.dart';
import 'package:sqflite/sqflite.dart';

///Clase Cortes de pelo con funciones de la bd
class CortePeloDao {
  /* AUN NO LO UTILIZO
  Future<void> addCorte(CortePelo cortePelo) async{
    final database= await DBHelper().openDataBase();
    await database.insert(
      'CortePelo', 
      cortePelo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    print('Corte de pelo creado');
  }
  */
  ///Obtiene todos los cortes de pelo
  Future<List<CortePelo>> getCortesPelo() async {
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.query('CortePelo');
    if (maps.isEmpty) {
      print('No hay cortes de pelo disponibles en la base de datos');
    }
    return List.generate(maps.length, (i) => CortePelo.fromMap(maps[i]));
  }
}