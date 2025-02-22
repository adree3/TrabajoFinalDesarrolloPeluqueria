import 'package:estructuratrabajofinal/model/Cita.dart';
import 'package:estructuratrabajofinal/view-model/CitasDAO.dart';
import 'package:flutter/material.dart';
import 'package:estructuratrabajofinal/model/Usuario.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Citas extends StatefulWidget {
  const Citas({super.key});
  State<Citas> createState()=> _Citas();
}
///Se muestran las citas
class _Citas extends State<Citas>{
  
  late Future<List<Map<String,dynamic>>>_citasConCortes = Future.value([]);
  @override
  void initState() {
    super.initState();
    actualizarAcudidoRecargar();
  }
  ///Devuelve una lista de mapas que teine una cita con su corte correspondiente
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
      debugPrint('Error cargando citas: $e \n $stackTrace');
      return [];
    }
  }
  ///Recarga las citas y actualiza si has acudido a una cita o no
  void actualizarAcudidoRecargar()async{
    await CitasDao().actualizarAcudido();
    setState(() {
      _citasConCortes = _cargarCitasConCortes();
    });
  }
  ///Si has acudido se pone en verde, sino no
  Color colorAcudido(String text){
    if(text=="Acudido"){
      return Colors.green;
    }else{
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    String nombreMes(String numMes){
      switch (numMes) {
        case "1":
          return "enero";
        case "2":
          return "febrero";
        case "3":
          return "marzo";
        case "4":
          return "abril";
        case "5":
          return "mayo";
        case "6":
          return "junio";
        case "7":
          return "julio";
        case "8":
          return "agosto";
        case "9":
          return "septiembre";
        case "10":
          return "octubre";
        case "11":
          return "noviembre";
        case "12":
          return "diciembre";
        default:
          return "error";
      }
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
            child: Text("${AppLocalizations.of(context)!.p4Error} ${snapshot.error}"),
          );
        }

        if(snapshot.data==null|| snapshot.data!.isEmpty){
          return Center(
            child: Text(AppLocalizations.of(context)!.p4NoCitas),
          );
        }               
        final listaCitas = snapshot.data!;
        
        return Scaffold(
          backgroundColor: Color(0xff5a5a5a),
          appBar: AppBar(
            backgroundColor: Color(0xff5a5a5a),
            title: Text(AppLocalizations.of(context)!.p4ListadoCitas,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            automaticallyImplyLeading: false

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
              String hora = '${fecha.hour.toString().padLeft(2,'0')}:${fecha.minute.toString().padLeft(2, '0')}';
              String dia = fecha.day.toString().padLeft(2,'0');
              String mes = fecha.month.toString();
              if(cita.acudido==1){
                acudidoText = AppLocalizations.of(context)!.p4Acudido;
              }else if(cita.acudido==0){
                acudidoText = AppLocalizations.of(context)!.p4NoAcudido;
              }
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(acudidoText, textAlign:TextAlign.center, style: TextStyle(color: colorAcudido(acudidoText), fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
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
                        const VerticalDivider(
                          thickness: 1,
                          width: 20,
                          color: Colors.black,
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
                    /*trailing: IconButton(
                      onPressed: () async{
                        await CitasDao().eliminarCita(cita);                                                    
                        setState(() {
                          _citasConCortes = _cargarCitasConCortes();
                        });
                      },
                      icon: const Icon(Icons.delete)
                    ),*/
                    leading: const Column( 
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5,)
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
  