class Barbero {
  final int? id;
  final String nombre;
  final int edad;
  final String rutaImagenBarbero;
  final String rutaPortafolio;

  Barbero({
    this.id,
    required this.nombre,
    required this.edad,
    required this.rutaImagenBarbero,
    required this.rutaPortafolio
  });
  
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'nombre': nombre,
      'edad': edad,
      'rutaImagenBarbero': rutaImagenBarbero,
      'rutaPortafolio': rutaPortafolio
    };
  }

  factory Barbero.fromMap(Map<String, dynamic> map){
    return Barbero(
      id: map['id'],
      nombre: map['nombre'], 
      edad: map['edad'],
      rutaImagenBarbero: map['rutaImagenBarbero'],
      rutaPortafolio: map['rutaPortafolio']
    );
  }

  @override
  String toString(){
    return 'Barbero(id: $id, nombre: $nombre, edad: $edad, rutaImagenBarbero: $rutaImagenBarbero, rutaPortafolio: $rutaPortafolio)';
  }
  //dadaduaiodpijafhoafoia x 2
}