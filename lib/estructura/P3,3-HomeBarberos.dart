import 'package:flutter/material.dart';
import 'package:estructuratrabajofinal/clases/Barbero.dart';
import 'package:estructuratrabajofinal/dao/BarberoDAO.dart';

class HomeBarberos extends StatefulWidget {
  const HomeBarberos({super.key});
  State<HomeBarberos> createState()=>_Principal();
}
class _Principal extends State<HomeBarberos>{
  late Future<List<Barbero>>_barberos;

  @override
  void initState() {
    super.initState();
    _barberos = BarberoDao().getBarberos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _barberos, 
      builder: (context, snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          print("datos recibidos");
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data==null|| snapshot.data!.isEmpty){
          return const Center(
            child: Text("No hay barberos disponibles"),
          );
        }
        if(snapshot.hasError){
          return Center(
            child: Text("error: ${snapshot.error}" ),
          );
        }
        final listaBarberos= snapshot.data!;

        return Scaffold(
          body: Column(
            children: [
              Expanded(child: 
                ListView.builder(
                  itemCount: listaBarberos.length,
                  itemBuilder: (Context, index){
                    final barbero= listaBarberos[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 500,
                          child: Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 5,),
                                Image.network(barbero.rutaImagenBarbero, height: 150, width: 150, ),
                                SizedBox(width: 15,),                                
                                Column(
                                  children: [
                                    Text(barbero.nombre),
                                    Text("${barbero.edad.toString()} años")
                                  ],
                                ),  
                                SizedBox(height: 5,)
                              ],
                            ),
                          ),
                        )
                      )
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
  
