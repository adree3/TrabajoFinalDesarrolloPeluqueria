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

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'nombre': nombre,
      'contrasena': contrasena,
      'email': email,
      'telefono': telefono,
    };
  }

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
     return 'Usuario(id: $id, nombre: $nombre, email: $email, telefono: $telefono)'; 
  }
}