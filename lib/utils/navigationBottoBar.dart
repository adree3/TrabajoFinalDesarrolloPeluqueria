/*import 'package:flutter/material.dart';
import '../estructura/P3_1-HomeServicios.dart';
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
          backgroundColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(color:Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.normal),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.date_range), label: "Citas"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Estadisticas"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil")
          ],
          currentIndex: _selectIndex,
          selectedItemColor: const Color.fromARGB(255, 0, 27, 100),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}*/