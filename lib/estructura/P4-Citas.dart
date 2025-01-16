import 'package:estructuratrabajofinal/bd/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:estructuratrabajofinal/clases/Cita.dart';
import 'package:estructuratrabajofinal/dao/CitasDAO.dart';

class Citas extends StatefulWidget {
  const Citas({super.key});
  State<Citas> createState()=> _Principal();
}
class _Principal extends State<Citas>{
  late Future<List<Map<String,dynamic>>>_citasConCortes;
  @override
  void initState() {
    super.initState();
    _citasConCortes = _cargarCitasConCortes();
  }
  Future<List<Map<String, dynamic>>> _cargarCitasConCortes() async{
    final citas = await CitasDao().getCitas();
    final List<Map<String, dynamic>> citasConCortes = [];
    for (final cita in citas){
      final corteInfo = await CitasDao().getCortePeloPorCitaId(cita.cortePeloId);
      citasConCortes.add({
        'cita': cita,
        'corte': corteInfo
      });
    }
    return citasConCortes;
  }
  @override
  Widget build(BuildContext context) {
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
        

        if(snapshot.connectionState==ConnectionState.done){
          print("datos recibidos");
          print(snapshot.data);
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
              String acudidoText="";
              DateTime fecha = DateTime.parse(cita.fecha);
              String hora = fecha.hour.toString().padLeft(2,'0') + ':' 
                + fecha.minute.toString().padLeft(2, '0');
              String dia = fecha.day.toString().padLeft(2,'0');
              String mes = fecha.month.toString().padLeft(2,'0');
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
                              Text(corteInfo?['Nombre']??"Corte no disponible"),
                              const SizedBox(height: 5,),
                              Text(corteInfo?['descripcion']??"No hay descripcion")
                            ],
                          ) 
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ 
                            Text(hora),
                            Text(dia),
                            Text(mes)
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
  