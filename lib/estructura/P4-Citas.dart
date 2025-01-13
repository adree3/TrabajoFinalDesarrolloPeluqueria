import 'package:estructuratrabajofinal/bd/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:estructuratrabajofinal/clases/Cita.dart';
import 'package:estructuratrabajofinal/dao/CitasDAO.dart';

class Citas extends StatefulWidget {
  const Citas({super.key});
  State<Citas> createState()=> _Principal();
}
class _Principal extends State<Citas>{
  late Future<List<Cita>> _citas;
  @override
  void initState() {
    super.initState();
    _citas = CitasDao().getCitas();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _citas, 
      builder: (context, snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.connectionState==ConnectionState.done){
          print("datos recibidos");
          print(snapshot.data);
        }
        /*if(snapshot.data==null|| snapshot.data!.isEmpty){
          return const Center(
            child: Text("No hay citas disponibles"),
          );
        }*/
        if(snapshot.hasError){
          return Center(
            child: Text("error: ${snapshot.error}"),
          );
        }
        final listaCitas = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Column(
              children: [
                Text("Listado citas"),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: listaCitas.length,
                  itemBuilder: (Context, index){
                    final cita= listaCitas[index];
                    String acudidoText="";
                    if(cita.acudido==1){
                      acudidoText = "Acudido";
                    }else if(cita.acudido==0){
                      acudidoText = "No acudido";
                    }
                    return FutureBuilder<Map<String, String>?>(
                      future: CitasDao().getCortePeloPorCitaId(cita.cortePeloId),
                      builder: (context, corteSnapshot){
                        if(corteSnapshot.connectionState==ConnectionState.waiting){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if(corteSnapshot.hasError){
                          return const Center(
                            child: Text("Ha ocurrido un error con los cortes de pelo"),
                          );
                        }
                        final corteInfo = corteSnapshot.data;
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            child: Card(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(acudidoText),
                                      Text(corteInfo?['nombre']?? "No disponible"),
                                      Text(corteInfo?['descripcion']?? "Sin descripcion")
                                    ],
                                  ),
                                  IconButton(onPressed: (){}, icon:Icon(Icons.delete)),
                                  const Column(
                                    children: [
                                      Text("Mes"),
                                      Text("Dia"),
                                      Text("Hora")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    );
                  } 
                )
              )
            ],
          ),
        );
      }
    );
  }
}
  