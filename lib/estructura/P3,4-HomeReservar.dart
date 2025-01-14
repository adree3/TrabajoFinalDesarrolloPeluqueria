import 'package:estructuratrabajofinal/clases/CortesPelo.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class HomeReserva extends StatefulWidget {
  final CortePelo corte;

  const HomeReserva({super.key, required this.corte});

  @override
  State<HomeReserva> createState() => _Principal();
}

class _Principal extends State<HomeReserva> {
  DateTime fechaActual = DateTime.now();
  DateTime fechaSeleccionada = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      fechaSeleccionada = day;
    });
  }

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
                Row(
                  children: [
                    const Text("Hora:"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Selecciona una hora",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Barbero:"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        items: const [
                          DropdownMenuItem(value: "1", child: Text("Barbero 1")),
                          DropdownMenuItem(value: "2", child: Text("Barbero 2")),
                        ],
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Selecciona un barbero",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción al presionar el botón
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
        Container(
          child: TableCalendar(
            locale: 'es_ES',
            rowHeight: 60,
            headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            focusedDay: fechaActual,
            firstDay: fechaActual, 
            lastDay: DateTime(fechaActual.year, fechaActual.month + 3),
            selectedDayPredicate: (day)=> isSameDay(day, fechaSeleccionada),
            onDaySelected: _onDaySelected,
            
          ),
        )
      ],
    );
  }
}
