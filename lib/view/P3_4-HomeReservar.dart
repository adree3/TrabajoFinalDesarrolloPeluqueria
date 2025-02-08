import 'package:estructuratrabajofinal/model/Barbero.dart';
import 'package:estructuratrabajofinal/model/Cita.dart';
import 'package:estructuratrabajofinal/model/CortesPelo.dart';
import 'package:estructuratrabajofinal/model/Usuario.dart';
import 'package:estructuratrabajofinal/view-model/BarberoDAO.dart';
import 'package:estructuratrabajofinal/view-model/CitasDAO.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeReserva extends StatefulWidget {
  final CortePelo corte;

  const HomeReserva({super.key, required this.corte});

  @override
  State<HomeReserva> createState() => _HomeReserva();
}
///Pantalla para reservar una cita
class _HomeReserva extends State<HomeReserva> {
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
  ///Actualiza cuando la fechaSeleccionada cambia
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      fechaSeleccionada = day;
    });
  }
  ///Devuelve la fecha formateada como se guarda en la base de datos
  String _devolverFecha(String horaSeleccionada, DateTime fechaSeleccionada){
    final fechaFormateada = DateFormat('yyyy-MM-dd').format(fechaSeleccionada);
    String fechaCompleta = "$fechaFormateada $horaSeleccionada:00";
    return fechaCompleta;
  }
  
  List<String> listaHoras = ['10:00', '11:30', '13:00', '16:30', '18:00', '20:36' , '21:30'  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5a5a5a),
      appBar: AppBar(
        backgroundColor: const Color(0xfffae8d0),
        title: Text("${widget.corte.nombre} - ${widget.corte.precio.toString()}€"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 600, 
            ),
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  calendario(),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listaHoras.length,
                        itemBuilder: (context, index) {
                          final hora = listaHoras[index];
                          bool isSelected = hora == horaSeleccionada;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  horaSeleccionada = hora;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                                foregroundColor: isSelected
                                    ? Colors.white
                                    : const Color.fromARGB(255, 164, 80, 179),
                                backgroundColor:
                                    isSelected ? Colors.blue : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(hora),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.p34Barbero,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FutureBuilder(
                          future: _barberos,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("${AppLocalizations.of(context)!.p34Error} ${snapshot.error}"),
                              );
                            }
                            if (snapshot.data == null || snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(AppLocalizations.of(context)!.p34NoHayBarberos),
                              );
                            }
                            final listaBarberos = snapshot.data!;
                            return DropdownButton<Barbero>(
                              isExpanded: true,
                              value: barberoSeleccionado,
                              onChanged: (Barbero? newValue) {
                                setState(() {
                                  barberoSeleccionado = newValue;
                                });
                              },
                              hint: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.p34SeleccionaUnBarbero,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              dropdownColor: Colors.white,
                              items: listaBarberos
                                  .map<DropdownMenuItem<Barbero>>((Barbero barbero) {
                                return DropdownMenuItem<Barbero>(
                                  value: barbero,
                                  child: Text(barbero.nombre),
                                );
                              }).toList(),
                              underline: Container(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (horaSeleccionada.isEmpty || barberoSeleccionado == null) {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                  AppLocalizations.of(context)!.p34RellenaCampos,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          );
                          return;
                        }
                        String fechaCompleta =
                            _devolverFecha(horaSeleccionada, fechaSeleccionada);
                        DateTime fechaCita = DateTime.parse(fechaCompleta);
                        DateTime fechaActual = DateTime.now();
                        int acudido =
                            fechaCita.isBefore(fechaActual) ? 1 : 0;
                        print(acudido);
                        int barberoid = barberoSeleccionado!.id!;
                        int corteid = widget.corte.id!;
                        Cita cita = Cita(
                            fecha: fechaCompleta,
                            acudido: acudido,
                            usuarioId: Usuario.usuarioActual!.id!,
                            barberoId: barberoid,
                            cortePeloId: corteid);
                        if (await CitasDao().addCita(cita)) {
                          Navigator.pop(context);
                        } else {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                  AppLocalizations.of(context)!.p34NoCrearLista,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.p34Reservar),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget calendario() {
    return Center(
      child: Container(
        width: 500,
        child: TableCalendar(
          locale: 'es_ES',
          rowHeight: 60,
          headerStyle: const HeaderStyle(
            formatButtonVisible: false, 
            titleCentered: true,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 18), 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white), 
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white), 
          ),
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Color.fromARGB(255, 217, 162, 89), 
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Color.fromARGB(255, 76, 142, 196), 
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(color: Colors.white), 
            weekendTextStyle: TextStyle(color: Colors.redAccent), 
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Color.fromARGB(255, 230, 164, 77), fontWeight: FontWeight.bold),
            weekendStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold), 
          ),
          availableGestures: AvailableGestures.all,
          focusedDay: fechaActual,
          firstDay: fechaActual,
          lastDay: DateTime(fechaActual.year, fechaActual.month + 3),
          selectedDayPredicate: (day) => isSameDay(day, fechaSeleccionada),
          onDaySelected: _onDaySelected,
          daysOfWeekHeight: 30,
          startingDayOfWeek: StartingDayOfWeek.monday,
        ),
      ),
    );
  }
}
