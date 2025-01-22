  import 'package:estructuratrabajofinal/clases/Barbero.dart';
  import 'package:flutter/material.dart';
  import 'package:estructuratrabajofinal/dao/BarberoDAO.dart';

  class HomePortafolio extends StatefulWidget {
    const HomePortafolio({super.key});

    State<HomePortafolio> createState()=>_Principal();
  }
  class _Principal extends State<HomePortafolio>{
    late Future<List<Barbero>>_barberos;

    @override
    void initState() {
      super.initState();
      _barberos = BarberoDao().getBarberos();
    } 
    @override
    Widget build(BuildContext context) {
      return FutureBuilder<List<Barbero>>(
        future: _barberos,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
              print("Datos recibidos: ${snapshot.data}");
          }

          if(snapshot.connectionState== ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data==null|| snapshot.data!.isEmpty){
            return const Center(
              child: Text("No hay barberos disponibles"),
            );
          }
          if(snapshot.hasError){
            return Center(
              child:  Text("Error: ${snapshot.error}"),
            );
          }
          
          final listaBarberos = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.grey,
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: listaBarberos.length,
                    itemBuilder: (context, index){
                      final barbero = listaBarberos[index];
                      /*String assetImage = barbero.rutaPortafolio.toString() != null && barbero.rutaPortafolio!.isNotEmpty 
                        ? barbero.rutaPortafolio! 
                        : "assets/images/default.jpg";*/
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),                      
                        child: Column(
                          children: [
                            Container(
                            height: 200,  
                            child: Image.network(
                              barbero.rutaPortafolio,
                              fit: BoxFit.cover, 
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 200,
                                );
                              },
                            ),
                          ),
                            /*
                            Image.asset(
                              assetImage,
                              height: 200,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 200,
                                );
                              },
                            )*/
                          ],
                        ),
                      );
                    } 
                  )
                )
              ],
            )
          );
        }
      );
    }
  }
    