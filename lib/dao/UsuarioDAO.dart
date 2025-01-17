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

  Future<bool> comprobarUsuario(String usu, String contrasna) async {
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> result = await database.query(
      'Usuario',
      where: 'email = ? AND contrasena = ?',
      whereArgs: [usu, contrasna],
    );
    return result.isNotEmpty;
  }

  Future<Usuario?> obtenerUsuarioPorId(int idUsuario)async{
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> res = await database.rawQuery('''
      SELECT *
      FROM Usuario
      WHERE id = ?
    ''', [idUsuario]);
    if (res.isNotEmpty){
      return Usuario.fromMap(res.first);
    }else{
      return null;
    }
  }
  
  Future<int> actualizarUsuarioContrasena(int idUsuario, String contrasena)async{
    final database= await DBHelper().openDataBase();
    Map<String,dynamic> valores = {
      'contrasena': contrasena
    };
    int filasAfect = await database.update(
      'Usuario', 
      valores,
      where: 'id=?',
      whereArgs: [idUsuario]
    );
    return filasAfect;

  }

  
}