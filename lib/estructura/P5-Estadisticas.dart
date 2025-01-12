import 'package:flutter/material.dart';

class Estadisticas extends StatelessWidget {
  const Estadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text("Estadisticas"),
          ],
        ),
      ),
      body: SingleChildScrollView( // Permite que la columna sea desplazable si hay más contenido
        child: const Column(
          children: [
            Text("Estadistica (no investigué aún cómo es)"),
            Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Citas acudidas"),
                      Expanded( // Hace que el TextField ocupe todo el espacio disponible
                        child: TextField(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Citas no acudidas"),
                      Expanded( // Hace que el TextField ocupe todo el espacio disponible
                        child: TextField(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Dinero gastado"),
                      Expanded( // Hace que el TextField ocupe todo el espacio disponible
                        child: TextField(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
