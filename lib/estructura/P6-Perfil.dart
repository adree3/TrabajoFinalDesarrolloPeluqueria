import 'package:estructuratrabajofinal/clases/Usuario.dart';
import 'package:estructuratrabajofinal/dao/usuarioDAO.dart';
import 'package:estructuratrabajofinal/estructura/p1-IniciarSesion.dart';
import 'package:estructuratrabajofinal/utils/providerTodos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

  class Perfil extends StatefulWidget {
    const Perfil({super.key});

    @override
    State<StatefulWidget> createState() => _perfil();
  }

  class _perfil extends State<Perfil>{
    static List<String> idiomas = ['es', 'en'];


    @override
    Widget build(BuildContext context) {
      final temaProvider = Provider.of<ProviderTodos>(context);
      
      


      return Scaffold(
        backgroundColor: Color(0xff5a5a5a),
        appBar: AppBar(
          backgroundColor: Color(0xff5a5a5a),
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.p6Perfil,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              children: [
                Text(AppLocalizations.of(context)!.p6Idioma, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                DropdownButton<String>(
                  value: temaProvider.idioma.languageCode,
                  onChanged: (String? newValue){
                    setState(() {
                      temaProvider.cambiarIdioma(newValue!);
                    });
                  },
                  items: idiomas.map((String value){
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value == 'es' ? 'Español' : 'English',style: TextStyle(color: Colors.white),)
                    );
                  }).toList(), 
                  dropdownColor: Colors.grey[600], 
                ),
                SizedBox(width: 10,)
              ],
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey[700],
                    backgroundImage: AssetImage("assets/images/perfil.jpg"),
                  ),
                  const SizedBox(width: 15),
                  
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

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _dialogo(context);
                      },
                      icon: Icon(Icons.lock_outline,color: Colors.white,),
                      label: Text(AppLocalizations.of(context)!.p6CambiaContrasena),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(360, 50),
                      )
                    ),
                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: () {
                        _mostrarDialogoConfirmacionCerrarSesion(context);
                      },
                      icon: Icon(Icons.logout,color: Colors.white,),
                      label: Text(AppLocalizations.of(context)!.p6CerrarSesion),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(360, 50),
                      )
                    ),
                    const SizedBox(height: 15),

                    ElevatedButton.icon(
                      onPressed: () {
                        _dialogoEliminarCuenta(context);
                      },
                      icon: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 255, 255)),
                      label: Text(AppLocalizations.of(context)!.p6EliminarCuenta),
                      style: _buttonStyle().copyWith(
                        
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                )
              )
            ],
          ),
        ),
      );
    }

    void _mostrarDialogoConfirmacionCerrarSesion(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff5a5a5a),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(AppLocalizations.of(context)!.p6CerrarSesion, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),textAlign:TextAlign.center,),
            content: Text(AppLocalizations.of(context)!.p6ConfirmarCerrarSesion, style: TextStyle(color: Colors.white),),
            
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
                    child: Text(
                      AppLocalizations.of(context)!.p6Cancelar,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const IniciarSesion()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.p6Aceptar,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    void _dialogoEliminarCuenta(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff5a5a5a),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text( AppLocalizations.of(context)!.p6ConfirmarEliminarCuenta, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,),
            content:Text(AppLocalizations.of(context)!.p6EliminarCuentaAdvertencia,style: TextStyle(color: Colors.white),),
            
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
                    child: Text(
                      AppLocalizations.of(context)!.p6Cancelar,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      Usuario? usu = Usuario.usuarioActual;
                      if(usu!=null){
                        await UsuarioDao().eliminarUsuario(usu);
                      }                      
                    },
                    child: Text(
                      AppLocalizations.of(context)!.p6Aceptar,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    ButtonStyle _buttonStyle() {
      return ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        minimumSize: Size(360, 50),
        shape: RoundedRectangleBorder(),
      );
    }
    

    void _dialogo(BuildContext context) {
      final _formKey = GlobalKey<FormState>();
      final TextEditingController _controllerContrasenaActual = TextEditingController();
      final TextEditingController _controllerContrasenaNueva = TextEditingController();
      final TextEditingController _controllerContrasenaNueva2 = TextEditingController();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff5a5a5a),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                Icon(Icons.lock, color: Color.fromARGB(255, 0, 0, 0)),
                SizedBox(width: 10),
                Text(
                  AppLocalizations.of(context)!.p6CambiaContrasena,
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
                          return AppLocalizations.of(context)!.p6IntroduceContrasenaActual;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText:AppLocalizations.of(context)!.p6ContrasenaActual,
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
                          return AppLocalizations.of(context)!.p6IntroduceConNueva;
                        }
                        if (_controllerContrasenaActual.text == value) {
                          return AppLocalizations.of(context)!.p6NoPuedesLaMisma;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.p6ContrasenaNueva,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      controller: _controllerContrasenaNueva2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.p6RepiteContrasena;
                        }
                        if (_controllerContrasenaNueva.text != value) {
                          return AppLocalizations.of(context)!.p6ContrasenasCoincidir;
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.p6RepiteLaContrasena,
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

                        child: Text(AppLocalizations.of(context)!.p6ActualizarContrasena),
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(
                              color: Colors.white, 
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
