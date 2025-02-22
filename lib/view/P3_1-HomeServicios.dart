import 'package:estructuratrabajofinal/model/CortesPelo.dart';
import 'package:estructuratrabajofinal/view-model/CortePeloDAO.dart';
import 'package:flutter/material.dart';
import 'P3_2-HomePortafolio.dart';
import 'P3_3-HomeBarberos.dart';
import 'P3_4-HomeReservar.dart';
import 'P4-Citas.dart';
import 'P5-Estadisticas.dart';
import 'P6-Perfil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeServicios extends StatefulWidget {
  const HomeServicios({super.key});

  @override
  State<HomeServicios> createState() => _HomeServicios();
}
///Contiene el bottomNavigation y TabBar
class _HomeServicios extends State<HomeServicios> {
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
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor:  Color(0xfffae8d0),
        title: Text(AppLocalizations.of(context)!.p31Peluqueria), 
        centerTitle: true,
        automaticallyImplyLeading: false
      ),
      body: _widgetOptions.elementAt(_selectIndex), 
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context)!.p31Inicio),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: AppLocalizations.of(context)!.p31Citas),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: AppLocalizations.of(context)!.p31Estadisticas),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: AppLocalizations.of(context)!.p31Perfil),
        ],
        currentIndex: _selectIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
///TabBar con 3 pestañas; servicios, portafolio y barberos
class TabBarContent extends StatelessWidget {
  const TabBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: const Color(0xfffae8d0), 
            child: TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context)!.p31Servicios),
                Tab(text: AppLocalizations.of(context)!.p31Portafolio),
                Tab(text: AppLocalizations.of(context)!.p31Barberos),
              ],
              labelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.black, 
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                Servicios(),
                HomePortafolio(),
                HomeBarberos(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Servicios extends StatefulWidget {
  const Servicios({super.key});

  State<Servicios> createState()=>_Servicios();
}
///Servicios, en el cual te sale los tipos de cortes de pelo que puedes reservar
class _Servicios extends State<Servicios> {
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
          return Center(
            child: Text(AppLocalizations.of(context)!.p31NoHayCortes),
          );
        }
        if(snapshot.hasError){
          return Center(
            child:  Text("${AppLocalizations.of(context)!.p31Error} ${snapshot.error}"),
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
                color: Color(0xff4a4a4a), 
                borderRadius: BorderRadius.circular(8.0), 
                boxShadow: [
                  BoxShadow(
                    color:  Color(0xfffae8d0).withOpacity(0.1), 
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
                        Text("${corte.duracion} ${AppLocalizations.of(context)!.p31Minutos}", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeReserva(corte: corte)));
                      },style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        textStyle: TextStyle(fontSize: 22)
                      ),
                     
                      child: Text(AppLocalizations.of(context)!.p31Reservar),
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
