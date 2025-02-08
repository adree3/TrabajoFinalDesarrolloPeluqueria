///Class Usuario el cual tiene un atributo estatico que tiene el usuarioActual
class Usuario {
  final int? id;
  final String nombre;
  final String contrasena;
  final String email;
  final int telefono;
  static Usuario? usuarioActual;

  Usuario({
    this.id,
    required this.nombre,
    required this.contrasena,
    required this.email,
    required this.telefono,
  });

  ///ToMap para convertirlo a mapa para meterlo en la bd
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nombre': nombre,
      'contrasena': contrasena,
      'email': email,
      'telefono': telefono,
    };
  }

  ///FromMap convierte de mapa a Usuario
  factory Usuario.fromMap(Map<String, dynamic> map){
    return Usuario(
      id: map['id'],
      nombre: map['nombre'], 
      contrasena: map['contrasena'], 
      email: map['email'], 
      telefono: map['telefono']
    );
  }
  @override
  String toString(){
     return 'Usuario(id: $id, nombre: $nombre, email: $email, contraseña: $contrasena, telefono: $telefono)'; 
  }
}