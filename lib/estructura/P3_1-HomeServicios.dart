import 'package:estructuratrabajofinal/clases/CortesPelo.dart';
import 'package:flutter/material.dart';
import 'P3_2-HomePortafolio.dart';
import 'P3_3-HomeBarberos.dart';
import 'P3_4-HomeReservar.dart';
import 'P4-Citas.dart';
import 'P5-Estadisticas.dart';
import 'P6-Perfil.dart';
import '../dao/CortePeloDAO.dart';
class HomeServicios extends StatefulWidget {
  const HomeServicios({super.key});

  @override
  State<HomeServicios> createState() => _Principal();
}

class _Principal extends State<HomeServicios> {
  int _selectIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TabBarContent(), 
    Citas(),         
    Estadisticas(), 
    Perfil(),        
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor:  Color(0xfffae8d0),
          title: Text("Peluquería"), 
          centerTitle: true,
        ),
        body: _widgetOptions.elementAt(_selectIndex), 
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:   Color.fromARGB(255, 214, 208, 199),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Citas"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Estadisticas"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ],
          currentIndex: _selectIndex,
          selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          unselectedItemColor: Color(0xff827462),
          onTap: _onItemTapped,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class TabBarContent extends StatelessWidget {
  const TabBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xfffae8d0),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Servicios", ),
              Tab(text: "Portafolio"),
              Tab(text: "Barberos"),
            ],labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 15),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            unselectedLabelColor: Colors.black,
          ),
        ),
        body: const TabBarView(
          children: [
            Servicios(),
            HomePortafolio(),
            HomeBarberos(),
          ],
        ),
      ),
    );
  }
}

class Servicios extends StatefulWidget {
  const Servicios({super.key});

  State<Servicios> createState()=>_Segunda();
}
class _Segunda extends State<Servicios> {
  late Future<List<CortePelo>> _cortesPelo;
  @override
  void initState() {
    super.initState();
    _cortesPelo = CortePeloDao().getCortesPelo();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff5a5a5a),
      child: FutureBuilder<List<CortePelo>>(
      future: _cortesPelo,
      builder: (context, snapshot){
        if(snapshot.connectionState== ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(!snapshot.hasData||snapshot.data!.isEmpty){
          return const Center(
            child: Text("No hay cortes de pelo disponibles"),
          );
        }
        if(snapshot.hasError){
          return Center(
            child:  Text("Error: ${snapshot.error}"),
          );
        }
        final cortesDePelo = snapshot.data!;

        return ListView.builder(
          itemCount: cortesDePelo.length,
          itemBuilder: (context, index) {
            final corte = cortesDePelo[index];
            return Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xff4a4a4a), // Fondo blanco para cada ítem
                borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color:  Color(0xfffae8d0).withOpacity(0.1), // Sombra para los ítems
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(corte.nombre, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                subtitle: Text(corte.descripcion, style: TextStyle(color: Colors.white)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Text("${corte.precio}€", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text("${corte.duracion} minutos", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeReserva(corte: corte)));
                      },
                     
                      child: const Text("Reservar"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
