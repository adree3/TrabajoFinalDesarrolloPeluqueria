import 'package:estructuratrabajofinal/bd/db_helper.dart';
import 'package:estructuratrabajofinal/clases/Usuario.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioDao {
  
  Future<void> addUser(Usuario usuario) async{
    final database= await DBHelper().openDataBase();
    await database.insert(
      'Usuario', 
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    print('usuario creado');
  }
  

  Future<List<Usuario>> getUsuarios() async{
    final database= await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.query('Usuario');
    
    return List.generate(maps.length, (i)=> Usuario.fromMap(maps[i]));
  }
}