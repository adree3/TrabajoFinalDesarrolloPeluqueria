import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text("Perfil"),
          ],
        ),
      ),
      body: Column(
        children: [
          const Text("imagen"),
          const Text("Cambiar contraseña"),
          Form(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Contraseña actual"),
                    // Expande el campo de texto para ocupar el espacio disponible
                    Expanded(
                      child: TextFormField(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Nueva contraseña"),
                    // Expande el campo de texto para ocupar el espacio disponible
                    Expanded(
                      child: TextFormField(),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Actualizar contraseña"),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Cerrar Sesion"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Eliminar Cuenta"),
          ),
        ],
      ),
    );
  }
}
