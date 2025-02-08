import 'package:estructuratrabajofinal/service/bd/db_helper.dart';
import 'package:estructuratrabajofinal/model/Usuario.dart';
import 'package:sqflite/sqflite.dart';

///Clase Usuario con funciones de la bd
class UsuarioDao {
  ///Eliminar el usuario por el id indicado
  Future<void> eliminarUsuario(Usuario usu) async{
    final database = await DBHelper().openDataBase();
    await database.delete("Usuario", where: "id=?", whereArgs: [usu.id]);
    print("usuario eliminado $usu ");
    
  }
  ///Crea un usuario por las credenciales recibidas
  Future<void> addUser(Usuario usuario) async{
    final database= await DBHelper().openDataBase();
    await database.insert(
      'Usuario', 
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    print('usuario creado');
  }
  
  ///Obtiene todos los usuario
  Future<List<Usuario>> getUsuarios() async{
    final database= await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.query('Usuario');
    
    return List.generate(maps.length, (i)=> Usuario.fromMap(maps[i]));
  }

  ///Devuelve un booleano si el usuario y la contraseña coinciden con las de la base de datos
  Future<bool> comprobarUsuario(String usu, String contrasna) async {
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> result = await database.query(
      'Usuario',
      where: 'email = ? AND contrasena = ?',
      whereArgs: [usu, contrasna],
    );
    return result.isNotEmpty;
  }

  ///Obtiene el usuario por su id
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
  
  ///Actualiza la contraseña por su id
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