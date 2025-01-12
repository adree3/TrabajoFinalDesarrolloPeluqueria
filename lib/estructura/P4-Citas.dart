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
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data==null||snapshot.data!.isEmpty){
          return Center(
            child: const Text("No hay citas disponibles"),
          );
        }
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
                  itemCount: 2,
                  itemBuilder: (Context, index){
                    final cita= listaCitas[index]
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        child: Card(
                          child: Row(
                            children: [
                              const Column(
                                children: [
                                  Text("acudido"),
                                  Text("Tipo corte"),
                                  Text("Descripcion")
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
                )
              )
            ],
          ),
        );
      }
    );
    
  }
}
  