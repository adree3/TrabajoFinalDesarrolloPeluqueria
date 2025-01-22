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
        appBar: AppBar(
          title: Text("Nombre"), 
          centerTitle: true,
        ),
        body: _widgetOptions.elementAt(_selectIndex), 
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Citas"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Estadisticas"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
          ],
          currentIndex: _selectIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
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
          bottom: const TabBar(
            tabs: [
              Tab(text: "Servicios"),
              Tab(text: "Portafolio"),
              Tab(text: "Barberos"),
            ],
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
    return FutureBuilder<List<CortePelo>>(
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
            return ListTile(
              title: Text(corte.nombre),
              subtitle: Text(corte.descripcion),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text("${corte.precio}€"),
                      Text("${corte.duracion} minutos"),
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
            );
          },
        );
      });
    
  }
}
