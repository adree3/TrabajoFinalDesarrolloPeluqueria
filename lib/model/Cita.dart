///Class Cita
class Cita{
  final int? id;
  final String fecha;
  final int acudido; 
  final int usuarioId;
  final int barberoId;
  final int cortePeloId;

  ///Constructor el cual tiene un assert que indica que la fecha tiene que tener el formato: YYYY-MM-DD HH:MM:SS
  Cita({
    this.id,
    required this.fecha,
    required this.acudido,
    required this.usuarioId,
    required this.barberoId,
    required this.cortePeloId,

  }): assert(RegExp(r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$').hasMatch(fecha), 
              'La fecha debe tener el formato YYYY-MM-DD HH:MM:SS');

  ///ToMap para convertirlo a mapa para meterlo en la bd
  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'fecha': fecha,
      'acudido': acudido,
      'usuarioId': usuarioId,
      'barberoId': barberoId,
      'cortePeloId': cortePeloId,
    };
  }

  ///FromMap convierte de mapa a Cita
  factory Cita.fromMap(Map<String, dynamic> map){
    return Cita(
      id: map['id'],
      fecha: map['fecha'], 
      acudido: map['acudido'], 
      usuarioId: map['usuarioId'], 
      barberoId: map['barberoId'], 
      cortePeloId: map['cortePeloId']
      
    );
  }

  @override
  String toString(){
    return 'Cita(id: $id, fecha: $fecha, acudido: $acudido, usuarioId: $usuarioId, barberoId: $barberoId, cortePeloId: $cortePeloId)';
  }

}