import 'package:estructuratrabajofinal/clases/Barbero.dart';
import 'package:estructuratrabajofinal/clases/Cita.dart';
import 'package:estructuratrabajofinal/clases/CortesPelo.dart';
import 'package:estructuratrabajofinal/clases/Usuario.dart';
import 'package:estructuratrabajofinal/dao/BarberoDAO.dart';
import 'package:estructuratrabajofinal/dao/CitasDAO.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
class HomeReserva extends StatefulWidget {
  final CortePelo corte;

  const HomeReserva({super.key, required this.corte});

  @override
  State<HomeReserva> createState() => _Principal();
}

class _Principal extends State<HomeReserva> {
  late Future<List<Barbero>> _barberos;
  Barbero? barberoSeleccionado;
  DateTime fechaActual = DateTime.now();
  DateTime fechaSeleccionada = DateTime.now();
  String horaSeleccionada = "";
  @override
  void initState() {
    super.initState();
    _barberos = BarberoDao().getBarberos();
  }
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      fechaSeleccionada = day;
      //print(horaSeleccionada);
      //print(fechaSeleccionada.day);
    });
  }
  String _devolverFecha(String horaSeleccionada, DateTime fechaSeleccionada){
    final fechaFormateada = DateFormat('yyyy-MM-dd').format(fechaSeleccionada);
    String fechaCompleta = "$fechaFormateada $horaSeleccionada:00";
    //print(fechaCompleta);
    return fechaCompleta;
  }
  
  List<String> listaHoras = ['10:00', '11:30', '13:00', '16:30', '18:00', '20:36' , '21:30'  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.corte.nombre} - ${widget.corte.precio.toString()}€"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                calendario(),
                const SizedBox(height: 10,),
                Divider(),
                const SizedBox(height: 5),
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                        itemCount: listaHoras.length,
                        itemBuilder: (context, index){       
                          final hora = listaHoras[index];
                          bool isSelected = hora == horaSeleccionada;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  horaSeleccionada = hora;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: isSelected? Colors.white : const Color.fromARGB(255, 164, 80, 179),
                                backgroundColor: isSelected ? Colors.blue : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(hora)
                            ),
                          );
                        }
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Divider(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Barbero:"),
                      const SizedBox(width: 10),
                    Expanded(
                      child: FutureBuilder(
                        future: _barberos, 
                        builder: (context, snapshot){
                          if(snapshot.connectionState==ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if(snapshot.hasError){
                            return Center(
                              child: Text("error ${snapshot.error}"),
                            );
                          }
                          if(snapshot.data==null || snapshot.data!.isEmpty){
                            return const Center(
                              child: Text("No hay barberos"),
                            );
                          }
                          final listaBarberos = snapshot.data!;
                          return DropdownButton(
                            value: barberoSeleccionado,
                            onChanged: (Barbero? newValue){
                              setState(() {
                                barberoSeleccionado = newValue;
                              });
                            },
                            hint: const Text("Selecciona un barbero"),
                            items: listaBarberos.map<DropdownMenuItem<Barbero>>((Barbero barbero){
                              return DropdownMenuItem<Barbero>(
                                value: barbero,
                                child: Text(barbero.nombre)

                              );
                            }).toList()
                          );
                        }
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if(horaSeleccionada.isEmpty || barberoSeleccionado ==null){
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Rellena todos los campos",
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        );
                        return;
                      }
                      String fechaCompleta= _devolverFecha(horaSeleccionada, fechaSeleccionada);
                      DateTime fechaCita = DateTime.parse(fechaCompleta);
                      DateTime fechaActual = DateTime.now();
                      int acudido = fechaCita.isBefore(fechaActual) ? 1: 0;
                      print(acudido);
                      int barberoid = barberoSeleccionado!.id!;
                      int corteid= widget.corte.id!;
                      Cita cita =Cita(fecha: fechaCompleta, acudido: acudido, usuarioId: Usuario.usuarioActual!.id!, barberoId: barberoid, cortePeloId: corteid);
                      if(await CitasDao().addCita(cita)){
                        Navigator.pop(context);
                      }else{
                        showDialog(
                          context: context,
                          barrierDismissible: true, // Cierra el diálogo al tocar fuera
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("No se pudo crear la cita",
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        );
                      }

                    },
                    child: const Text("Reservar"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget calendario(){
    return Center(
          child: Container(
            width: 500,
            child: TableCalendar(
              locale: 'es_ES',
              rowHeight: 60,
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true,),
              availableGestures: AvailableGestures.all,
              focusedDay: fechaActual,
              firstDay: fechaActual, 
              lastDay: DateTime(fechaActual.year, fechaActual.month + 3),
              selectedDayPredicate: (day)=> isSameDay(day, fechaSeleccionada),
              onDaySelected: _onDaySelected,
              daysOfWeekHeight: 30,
              startingDayOfWeek: StartingDayOfWeek.monday,
            ),
          ),
        );
  }
}
