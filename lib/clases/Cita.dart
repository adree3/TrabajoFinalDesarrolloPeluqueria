class Cita{
  final int? id;
  final String fecha;
  final int usuarioId;
  final int barberoId;
  final int cortePeloId;

  Cita({
    this.id,
    required this.fecha,
    required this.usuarioId,
    required this.barberoId,
    required this.cortePeloId,

  }): assert(RegExp(r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$').hasMatch(fecha), 
              'La fecha debe tener el formato YYYY-MM-DD HH:MM:SS');

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'fecha': fecha,
      'usuarioId': usuarioId,
      'barberoId': barberoId,
      'cortePeloId': cortePeloId,
    };
  }

  factory Cita.fromMap(Map<String, dynamic> map){
    return Cita(
      id: map['id'],
      fecha: map['fecha'], 
      usuarioId: map['usuarioId'], 
      barberoId: map['barberoId'], 
      cortePeloId: map['cortePeloId']
      
    );
  }

  @override
  String toString(){
    return 'Cita(id: $id, fecha: $fecha, usuarioId: $usuarioId, barberoId: $barberoId, cortePeloId: $cortePeloId)';
  }

}