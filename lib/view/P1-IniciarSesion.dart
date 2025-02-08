import 'package:estructuratrabajofinal/service/bd/db_helper.dart';
import 'package:estructuratrabajofinal/model/Usuario.dart';
import 'package:estructuratrabajofinal/view-model/UsuarioDAO.dart';
import 'package:flutter/material.dart';
import 'P2-Registrarse.dart';
import 'P3_1-HomeServicios.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({super.key});

  State<IniciarSesion> createState() => _IniciarSesion();
}

class _IniciarSesion extends State<IniciarSesion> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final dbhelper = DBHelper();

  /// Comprueba que el usuario exista en la BD
  Future<void> _login() async {
    final email = _emailController.text;
    final contrasena = _contrasenaController.text;

    final users = await UsuarioDao().getUsuarios();
    Usuario? user;

    for (var u in users) {
      if (u.email == email && u.contrasena == contrasena) {
        user = u;
        break;
      }
    }

    if (user != null) {
      print("Iniciando sesión");
      Usuario.usuarioActual = user;
      print(user);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeServicios()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.p1CredencialesIncorrectas)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final altoPantalla = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.9,
            colors: [
              Color.fromARGB(255, 140, 140, 140),
              Color.fromARGB(255, 113, 113, 113),
              Color.fromARGB(255, 77, 77, 77),
              Color.fromARGB(255, 73, 73, 73),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: altoPantalla * 0.8),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Semantics(
                      label: "Título de la pantalla: Identifícate",
                      //label: AppLocalizations.of(context)!.p1SemanticsIdentificate, //DEBERIA SER ESTO PERO NO PUEDO HACER flutter gen-l10n

                      header: true,
                      child: Text(
                        AppLocalizations.of(context)!.p1Identificate,
                        style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 35),
                    Form(
                      key: _formKey,
                      child: Container(
                        width: 700,
                        child: Column(
                          children: [
                            Semantics(
                              label: "Campo para ingresar correo electrónico",
                              //label: AppLocalizations.of(context)!.p1SemanticsCorreo, //DEBERIA SER ESTO PERO NO PUEDO HACER flutter gen-l10n
                              hint: "Introduce tu correo electrónico",
                              //hint: AppLocalizations.of(context)!.p1SemanticsHintCorreo, //DEBERIA SER ESTO PERO NO PUEDO HACER flutter gen-l10n
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!.p1IntroduceMail;
                                  }
                                  final RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                                  if (!regex.hasMatch(value)) {
                                    return "Introduce un correo válido (ejemplo@gmail.com)";
                                    //return AppLocalizations.of(context)!.p1ValidarEmail; //DEBERIA SER ESTO PERO NO PUEDO HACER flutter gen-l10n
                                  }
                                  
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.p1Email,
                                  prefixIcon: Icon(Icons.email),
                                ),
                                style: TextStyle(color: Color(0xFFfdf7e5)),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Semantics(
                              label: "Campo para ingresar contraseña",
                              //label: AppLocalizations.of(context)!.p1SemanticsContrasena, //DEBERIA SER ESTO PERO NO PUEDO HACER flutter gen-l10n
                              hint: "Introduce tu contraseña",
                              //label: AppLocalizations.of(context)!.p1SemanticsHintContrasena, //DEBERIA SER ESTO PERO NO PUEDO HACER flutter gen-l10n
                              child: TextFormField(
                                controller: _contrasenaController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!.p1IntroduceContrasena;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.p1Contrasena,
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                style: TextStyle(color: Color(0xFFfdf7e5)),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Semantics(
                              label: "Botón para iniciar sesión",
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _login();
                                  }
                                },
                                child: Text(AppLocalizations.of(context)!.p1IniciarSesion),
                              ),
                            ),
                            const SizedBox(height: 90),
                            Semantics(
                              excludeSemantics: true,
                              child: Text(
                                AppLocalizations.of(context)!.p1NotienesCuenta,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Semantics(
                              label: "Botón para registrarse si no tienes cuenta",
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Registrarse()),
                                  );
                                },
                                child: Text(AppLocalizations.of(context)!.p1Registrate),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
