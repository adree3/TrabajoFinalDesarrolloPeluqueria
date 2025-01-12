import 'package:flutter/material.dart';
import '../estructura/P3,1-HomeServicios.dart';
import '../estructura/P4-Citas.dart';
import '../estructura/P5-Estadisticas.dart';
import '../estructura/P6-Perfil.dart';


class Principal extends StatefulWidget{
  const Principal({super.key});

  State<Principal> createState()=>_Principal();
}

class _Principal extends State<Principal> {
  int _selectIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeServicios(),
    Citas(),
    Estadisticas(),
    Perfil()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Actividad 30',
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectIndex),
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color:Color.fromARGB(255, 0, 0, 0)),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.date_range), label: "Citas"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Estadisticas"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil")
          ],
          currentIndex: _selectIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}