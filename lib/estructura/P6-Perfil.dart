  import 'package:estructuratrabajofinal/clases/Usuario.dart';
  import 'package:estructuratrabajofinal/dao/UsuarioDAO.dart';
  import 'package:estructuratrabajofinal/estructura/P1-IniciarSesion.dart';
  import 'package:flutter/material.dart';

  class Perfil extends StatelessWidget {
    const Perfil({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xff5a5a5a),
        appBar: AppBar(
          backgroundColor: Color(0xff5a5a5a),
          automaticallyImplyLeading: false,
          title: const Text(
            "Perfil",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Avatar + Información del usuario
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80, // Ajusta el tamaño si es necesario
                    backgroundColor: Colors.grey[700],
                    backgroundImage: AssetImage("assets/images/perfil.jpg"),
                  ),
                  const SizedBox(width: 15), // Espacio entre el avatar y la info
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Usuario.usuarioActual!.email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        Usuario.usuarioActual!.telefono.toString(), // Teléfono
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Botón cambiar contraseña
              ElevatedButton.icon(
                onPressed: () {
                  _dialogo(context);
                },
                icon: Icon(Icons.lock_outline,color: Colors.white,),
                label: Text("Cambiar Contraseña"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                )
              ),
              const SizedBox(height: 15),

              // Botón cerrar sesión
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IniciarSesion()));
                },
                icon: Icon(Icons.logout,color: Colors.white,),
                label: Text("Cerrar Sesión"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 50),
                )
              ),
              const SizedBox(height: 15),

              // Botón eliminar cuenta
              ElevatedButton.icon(
                onPressed: () {
                  // Lógica para eliminar cuenta
                },
                icon: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 255, 255)),
                label: Text("Eliminar Cuenta"),
                style: _buttonStyle().copyWith(
                  
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Estilo de los botones
    ButtonStyle _buttonStyle() {
      return ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        minimumSize: Size(270, 50),
        shape: RoundedRectangleBorder(),
      );
    }
    

    // Diálogo para cambiar la contraseña
    void _dialogo(BuildContext context) {
      final _formKey = GlobalKey<FormState>();
      final TextEditingController _controllerContrasenaActual = TextEditingController();
      final TextEditingController _controllerContrasenaNueva = TextEditingController();
      final TextEditingController _controllerContrasenaNueva2 = TextEditingController();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff5a5a5a),// const Color(0xfffae8d0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.lock, color: Color.fromARGB(255, 0, 0, 0)),
                SizedBox(width: 10),
                Text(
                  "Cambia la contraseña",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      obscureText: true,
                      controller: _controllerContrasenaActual,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Introduce tu contraseña actual";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Introduce tu contraseña actual",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    
                    const SizedBox(height: 15,),
                    Divider(),
                    const SizedBox(height: 15),
                    TextFormField(
                      obscureText: true,
                      controller: _controllerContrasenaNueva,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Introduce una contraseña nueva";
                        }
                        if (_controllerContrasenaActual.text == value) {
                          return "No puedes introducir la misma contraseña que la actual";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Introduce una contraseña nueva",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      controller: _controllerContrasenaNueva2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Repite la contraseña nueva";
                        }
                        if (_controllerContrasenaNueva.text != value) {
                          return "Las contraseñas nuevas tienen que coincidir";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Repite la contraseña nueva",
                        labelStyle: TextStyle(color: Colors.white),
                        
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          Usuario? user = Usuario.usuarioActual;
                          if (_formKey.currentState!.validate()) {
                            if (await UsuarioDao().comprobarUsuario(user!.email, _controllerContrasenaActual.text)) {
                              if (await UsuarioDao().actualizarUsuarioContrasena(user.id!, _controllerContrasenaNueva.text) != 0) {
                                Usuario.usuarioActual = await UsuarioDao().obtenerUsuarioPorId(user.id!);
                                Navigator.of(context).pop();
                              }
                            }
                          }
                        },

                        child: const Text("Actualizar contraseña"),
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(
                              color: Colors.white, // Borde blanco
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
