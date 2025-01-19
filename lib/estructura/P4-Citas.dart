import 'package:flutter/material.dart';
import 'package:estructuratrabajofinal/clases/Cita.dart';
import 'package:estructuratrabajofinal/dao/CitasDAO.dart';
import 'package:estructuratrabajofinal/clases/Usuario.dart';

class Citas extends StatefulWidget {
  const Citas({super.key});
  State<Citas> createState()=> _Principal();
}
class _Principal extends State<Citas>{
  
  late Future<List<Map<String,dynamic>>>_citasConCortes;
  @override
  void initState() {
    super.initState();
    actualizarAcudidoRecargar();
  }
  Future<List<Map<String, dynamic>>> _cargarCitasConCortes() async {
    try {
      final citas = await CitasDao().getCitasPorIdUsuario(Usuario.usuarioActual!.id!);
      final List<Map<String, dynamic>> citasConCortes = [];
      for (final cita in citas) {
        final corteInfo = await CitasDao().getCortePeloPorCitaId(cita.cortePeloId);
        citasConCortes.add({
          'cita': cita,
          'corte': corteInfo,
        });
      }
      return citasConCortes;
    } catch (e, stackTrace) {
      debugPrint('Error loading citas: $e\n$stackTrace');
      return [];
    }
  }
  void actualizarAcudidoRecargar()async{
    await CitasDao().actualizarAcudido();
    setState(() {
      _citasConCortes = _cargarCitasConCortes();
    });
  }

  @override
  Widget build(BuildContext context) {
    String nombreMes(String numMes){
      String mes = "";
      switch(numMes){
        case "1": 
          mes= "enero";
        case "2": 
          mes= "febrero";
        case "3": 
          mes= "marzo";
        case "4": 
          mes= "abril";
        case "5": 
          mes= "mayo";
        case "6": 
          mes= "junio";
        case "7": 
          mes= "julio";
        case "8": 
          mes= "agosto";
        case "9": 
          mes= "septiembre";
        case "10": 
          mes= "octubre";
        case "11": 
          mes= "noviembre";
        case "12": 
          mes= "diciembre";
        default:
          mes = "error";
      }
      return mes;
    }
    return FutureBuilder(
      future: _citasConCortes, 
      builder: (context, snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.hasError){
          print(snapshot.error);
          return Center(
            child: Text("error: ${snapshot.error}"),
          );
        }

        if(snapshot.data==null|| snapshot.data!.isEmpty){
          return const Center(
            child: Text("No hay citas disponibles"),
          );
        }               
        final listaCitas = snapshot.data!;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Listado de citas"),
          ),
          body: ListView.builder(
            itemCount: listaCitas.length,
            itemBuilder: (context, index){
              final citaData= listaCitas[index];
              final Cita cita = citaData['cita'] as Cita;
              final Map<String, dynamic>? corteInfo = citaData['corte'] as Map<String, dynamic>?;
              print(corteInfo);
              String acudidoText="";
              DateTime fecha = DateTime.parse(cita.fecha);
              String hora = fecha.hour.toString().padLeft(2,'0') + ':' 
                + fecha.minute.toString().padLeft(2, '0');
              String dia = fecha.day.toString().padLeft(2,'0');
              String mes = fecha.month.toString();
              if(cita.acudido==1){
                acudidoText = "Acudido";
              }else if(cita.acudido==0){
                acudidoText = "No acudido";
              }
              return Padding(
                padding: EdgeInsets.all(8),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                corteInfo?['nombre'] ?? "Corte no disponible",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                corteInfo?['descripcion'] ?? "No hay descripcion",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [ 
                            Text(hora),
                            Text(dia),
                            Text(nombreMes(mes))
                          ],
                        )
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () async{
                        await CitasDao().eliminarCita(cita);                                                    
                        setState(() {
                          _citasConCortes = _cargarCitasConCortes();
                        });
                      },
                      icon: const Icon(Icons.delete)
                    ),
                    leading: Column( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(acudidoText)
                      ],
                    ),
                  )
                ),
              );
            } 
          )
        );
      }
    );
  }
}
  