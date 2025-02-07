import 'package:flutter/material.dart';
import 'package:estructuratrabajofinal/clases/barbero.dart';
import 'package:estructuratrabajofinal/dao/barberoDAO.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          return Center(
            child: Text(AppLocalizations.of(context)!.p33NoHayBarberos),
          );
        }
        if(snapshot.hasError){
          return Center(
            child: Text("${AppLocalizations.of(context)!.p33Error} ${snapshot.error}" ),
          );
        }
        final listaBarberos= snapshot.data!;

        return Scaffold(
          backgroundColor:Color(0xff5a5a5a),
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
                                    Text("${barbero.edad.toString()} ${AppLocalizations.of(context)!.p33Anos}")
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
  
