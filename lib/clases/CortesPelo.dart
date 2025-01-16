import 'package:estructuratrabajofinal/bd/db_helper.dart';

class CortePelo {
  final int? id;
  final String nombre;
  final String descripcion;
  final int precio;
  final int duracion;

  CortePelo({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.duracion,
  });

  Map<String,dynamic> toMap(){
    return{
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'duracion': duracion
    };
  }

  factory CortePelo.fromMap(Map<String,dynamic> map){
    return CortePelo(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      precio: map['precio'],
      duracion: map['duracion'],
    );
  }

  Future<bool> existeCortePelo(int cortePeloId) async {
  final database = await DBHelper().openDataBase();
  final List<Map<String, dynamic>> result = await database.query(
    'CortePelo',
    where: 'id = ?',
    whereArgs: [cortePeloId],
  );
  return result.isNotEmpty;
}

  @override
  String toString(){
    return 'Corte de pelo(id: $id, nombre: $nombre, descripcion: $descripcion, precio: $precio, duracion: $duracion)';
  }
}