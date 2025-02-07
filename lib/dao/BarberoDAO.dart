import 'package:estructuratrabajofinal/bd/db_helper.dart';
import 'package:estructuratrabajofinal/clases/barbero.dart';
import 'package:sqflite/sqflite.dart';

class BarberoDao {
  
  Future<void> addBarbero(Barbero barbero) async{
    final database= await DBHelper().openDataBase();
    await database.insert(
      'Barbero', 
      barbero.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    print('Corte de pelo creado');
  }
  

  Future<List<Barbero>> getBarberos() async {
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.query('Barbero');
    return List.generate(maps.length, (i) => Barbero.fromMap(maps[i]));
  }
}