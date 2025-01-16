import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  Future<Database> openDataBase() async {
  print("creando bd");
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'peluqueria.db');

  return openDatabase(path, onCreate: (db, version) async {
    try {
      print("bd creada");
      //USUARIO
      await db.execute(''' 
        CREATE TABLE Usuario (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT, 
          contrasena TEXT, 
          email TEXT, 
          telefono INTEGER
        )
      ''');
      await db.insert(
        'Usuario',
        {
          'nombre': 'Adrian',
          'contrasena': 'a',
          'email': 'a',
          'telefono': 123445678,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      //CORTE DE PELO
      await db.execute(''' 
        CREATE TABLE CortePelo (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          descripcion TEXT, 
          precio INTEGER,
          duracion INTEGER
        )
      ''');
      await db.insert(
        'CortePelo',
        {
          'nombre': 'Corte degradado al 0',
          'descripcion': 'corte degradado elaborado al 0',
          'precio': 18,
          'duracion': 30,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.insert(
        'CortePelo',
        {
          'nombre': 'Corte degradado y barba',
          'descripcion': 'corte degradado elaborado al 0 con barba',
          'precio': 20,
          'duracion': 50,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.insert(
        'CortePelo',
        {
          'nombre': 'Corte Ronaldo nazario',
          'descripcion': 'corte al 0 espectacular',
          'precio': 15,
          'duracion': 20,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      //BARBERO
      await db.execute(''' 
        CREATE TABLE Barbero (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          edad INTEGER, 
          rutaImagenBarbero TEXT, 
          rutaPortafolio TEXT
        )
      ''');
      await db.insert(
        'Barbero',
        {
          'nombre': 'Alison',
          'edad': 23,
          'rutaImagenBarbero': 'https://inmofotos.es/wp-content/uploads/2021/10/imagen-1_Mesa-de-trabajo-1.jpg',
          'rutaPortafolio': 'https://inmofotos.es/wp-contSent/uploads/2021/10/imagen-1_Mesa-de-trabajo-1.jpg',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await db.insert(
        'Barbero',
        {
          'nombre': 'Javier',
          'edad': 33,
          'rutaImagenBarbero': 'https://www.clarin.com/img/2023/12/01/rhVeUAooY_2000x1500__1.jpg',
          'rutaPortafolio': 'https://i.pinimg.com/236x/8c/fb/97/8cfb9734a4b89553a64a1c07c9631f47.jpg',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      //CITA (acudido es un boolean)
      await db.execute(''' 
        CREATE TABLE Cita (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fecha TEXT, 
          acudido INTEGER, 
          usuarioId INTEGER, 
          barberoId INTEGER, 
          cortePeloId INTEGER,
          FOREIGN KEY(usuarioId) REFERENCES Usuario(id),
          FOREIGN KEY(barberoId) REFERENCES Barbero(id),
          FOREIGN KEY(cortePeloId) REFERENCES CortePelo(id) ON DELETE SET NULL
        )
      ''');
      await db.insert(
        'Cita',
        {
          'fecha': '2024-10-20 13:30:00',
          'acudido': 1,
          'usuarioId': 1,
          'barberoId': 1,
          'cortePeloId': 1,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      ); 
      
    } catch (e) {
      print("Error al crear la base de datos o insertar datos: $e");
    }
  }, version: 1);
}
  Future<void> eliminarBD()async{
    final databasePath = await getDatabasesPath();
    final path= join(databasePath, 'peluqueria.db');

    await deleteDatabase(path);
    
  }
}