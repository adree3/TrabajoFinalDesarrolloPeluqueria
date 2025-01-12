import 'package:estructuratrabajofinal/bd/db_helper.dart';
import 'package:estructuratrabajofinal/clases/CortesPelo.dart';
import 'package:sqflite/sqflite.dart';

class CortePeloDao {
  
  Future<void> addUser(CortePelo cortePelo) async{
    final database= await DBHelper().openDataBase();
    await database.insert(
      'CortePelo', 
      cortePelo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    print('Corte de pelo creado');
  }
  

  Future<List<CortePelo>> getCortesPelo() async{
    final database= await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.query('CortePelo');
    
    return List.generate(maps.length, (i)=> CortePelo.fromMap(maps[i]));
  }
}