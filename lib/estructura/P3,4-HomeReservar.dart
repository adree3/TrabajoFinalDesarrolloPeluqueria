import 'package:flutter/material.dart';

class HomeReserva extends StatefulWidget {
  const HomeReserva({super.key});

  @override
  State<HomeReserva> createState() => _Principal();
}

class _Principal extends State<HomeReserva> {
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
                const Text(
                  "Selecciona una fecha y hora:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
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
}
