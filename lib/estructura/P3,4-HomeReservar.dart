import 'package:estructuratrabajofinal/clases/Barbero.dart';
import 'package:estructuratrabajofinal/clases/Cita.dart';
import 'package:estructuratrabajofinal/clases/CortesPelo.dart';
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
      print(horaSeleccionada);
      print(fechaSeleccionada.day);
    });
  }
  String _devolverFecha(String horaSeleccionada, DateTime fechaSeleccionada){
    final fechaFormateada = DateFormat('yyyy-MM-dd').format(fechaSeleccionada);
    String fechaCompleta = "$fechaFormateada $horaSeleccionada:00";
    print(fechaCompleta);
    return fechaCompleta;
  }
  
  List<String> listaHoras = ['10:00', '11:30', '13:00', '16:30', '18:00', '20:30' , '21:30'  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nombre"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("${widget.corte.nombre} - ${widget.corte.precio.toString()}€"),
                ),
                const SizedBox(height: 10),
                content(),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 60,
                  
                  child: Center(
                    child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                        itemCount: listaHoras.length,
                        itemBuilder: (context, index){       
                          final hora = listaHoras[index];
                          bool isSelected = hora == horaSeleccionada;

                          return Padding(
                            padding: const EdgeInsets.all(8),
                                child: Container(
                                width: 100,
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: (){
                                      setState(() {
                                        horaSeleccionada = hora;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: isSelected? Colors.white : const Color.fromARGB(255, 164, 80, 179),
                                      backgroundColor: isSelected ? Colors.blue : Colors.white,

                                    ),
                                    child: Text(hora)
                                  ),
                                ),
                              ),
                          );
                        }
                      ),
                  )
                ),
                const SizedBox(height: 20),
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
                    onPressed: () {
                      String fechaCompleta= _devolverFecha(horaSeleccionada, fechaSeleccionada);
                      int barberoid = barberoSeleccionado!.id!;
                      int corteid= widget.corte.id!;
                      Cita cita =Cita(fecha: fechaCompleta, acudido: 0, usuarioId: 1, barberoId: barberoid, cortePeloId: corteid);
                      //CitasDao().addCita(cita);
                    },
                    child: const Text("Reservar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget content(){
    return Column(
      children: [
        Center(
          child: Container(
            width: 400,
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
        )
      ],
    );
  }
}
