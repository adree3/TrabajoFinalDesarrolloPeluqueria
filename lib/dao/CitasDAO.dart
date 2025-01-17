import 'package:estructuratrabajofinal/bd/db_helper.dart';
import 'package:estructuratrabajofinal/clases/Cita.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class CitasDao {
  
  Future<bool> addCita(Cita cita) async{
    final database= await DBHelper().openDataBase();
    final List<Map<String, dynamic>> result = await database.query(
      'CortePelo',
      where: 'id = ?',
      whereArgs: [cita.cortePeloId],
    );
    if(result.isNotEmpty){
      await database.insert(
        'Cita', 
        cita.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
      print('Cita creada $cita');
      return true;
    }else{
      print("Error con ${cita.cortePeloId}");
      return false;
    }

    
  }
  
  Future<void> eliminarCita(Cita cita) async{
    final database = await DBHelper().openDataBase();
    await database.delete("Cita", where: "id=?", whereArgs: [cita.id]);
    print("usuario eliminado $cita \n");

    
  }

  Future<List<Cita>> getCitas() async {
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.query('Cita');
    print("Consulta Cita: $maps"); 
    return List.generate(maps.length, (i) => Cita.fromMap(maps[i]));
  }

  Future<List<Cita>> getCitasPorIdUsuario(int idUsuario) async {
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.query(
      'Cita',
      where: 'usuarioId = ?',
      whereArgs: [idUsuario]
    );
    print("Consulta Cita por idUsuario: $maps"); 
    return List.generate(maps.length, (i) => Cita.fromMap(maps[i]));
  }

  Future<Map<String, String>?> getCortePeloPorCitaId(int citaId) async {
    final database = await DBHelper().openDataBase();
    final List<Map<String, dynamic>> maps = await database.rawQuery('''
      SELECT CortePelo.nombre, CortePelo.descripcion
      FROM Cita
      JOIN CortePelo ON Cita.cortePeloId = CortePelo.id
      WHERE Cita.id = ?
    ''', [citaId]);

    if (maps.isNotEmpty) {
      return {
        'nombre': maps[0]['nombre'] as String,
        'descripcion': maps[0]['descripcion'] as String,
      };
    } else {
        print('No se encontró ningún corte asociado para la cita con ID: $citaId');
      return null;
    }
  }
  Future<void> actualizarAcudido() async{
    final database = await DBHelper().openDataBase();
    final fechaActual = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    await database.rawUpdate(
      '''
      UPDATE Cita
      SET acudido = 1
      WHERE fecha < ?
      ''', [fechaActual]
    );
  }
}