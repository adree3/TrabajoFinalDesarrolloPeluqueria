import 'package:estructuratrabajofinal/model/Usuario.dart';
import 'package:estructuratrabajofinal/view-model/UsuarioDAO.dart';
import 'package:estructuratrabajofinal/view/P1-IniciarSesion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

  State<Registrarse> createState()=>_Registrarse();

}
///Registrarse si no tienes cuenta
class _Registrarse extends State<Registrarse>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerTelefono = TextEditingController();
  final TextEditingController _controllerContrasena = TextEditingController();
  final TextEditingController _controllerContrasena2 = TextEditingController();
  ///Comprueba si el email ya existe
  Future<void> _comprobarEmail() async{
    final email= _controllerEmail.text;

    final users = await UsuarioDao().getUsuarios();
    Usuario? user;

    for(var u in users){
      if(u.email==email){
        user= u;
        break;
      }
    }
    if(user==null){
      crearUser();
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(AppLocalizations.of(context)!.p2UsuarioCreado))
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(AppLocalizations.of(context)!.p2YaHayUna))
      );
    }
  }
  ///Crea el usuario con las credenciales proporcionadas
  Future<void> crearUser() async{
    Usuario userNuevo = Usuario(
        nombre: _controllerNombre.text, 
        contrasena: _controllerContrasena.text, 
        email: _controllerEmail.text, 
        telefono: int.parse(_controllerTelefono.text)
    );
    UsuarioDao().addUser(userNuevo);
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
            colors:[
              Color.fromARGB(255, 140, 140, 140),
              Color.fromARGB(255, 113, 113, 113),
              Color.fromARGB(255, 77, 77, 77),
              Color.fromARGB(255, 73, 73, 73),
            ]
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: altoPantalla*0.8
                ), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(AppLocalizations.of(context)!.p2Registrate, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Form(
                      key: _formKey,
                      child: Container(
                        width: 700,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _controllerNombre,
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return AppLocalizations.of(context)!.p2IntroduceNombre;
                                }
                                return null;
                                },
                              decoration:  InputDecoration(
                                labelText: AppLocalizations.of(context)!.p2Nombre,
                                prefixIcon: Icon(Icons.person_off,),
                              ),
                              style: TextStyle(color: Color(0xFFfdf7e5)),
                            ),
                
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: _controllerEmail,
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return AppLocalizations.of(context)!.p2IntroduceEmail;
                                }
                                return null;
                                },
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.p2Email,
                                prefixIcon: Icon(Icons.mail,),
                                
                              ),
                              style: TextStyle(color: Color(0xFFfdf7e5)),
                            ),
                
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: _controllerTelefono,
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return AppLocalizations.of(context)!.p2IntroduceTelefono;
                                }
                                return null;
                                },
                              decoration:  InputDecoration(
                                labelText: AppLocalizations.of(context)!.p2Telefono,
                                prefixIcon: Icon(Icons.phone,),
                                
                              ),
                              style: TextStyle(color: Color(0xFFfdf7e5)),
                            ),
                
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: _controllerContrasena,
                              obscureText: true,
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return AppLocalizations.of(context)!.p2IntroduceContrasena;
                                }
                                return null;
                                },
                              decoration:  InputDecoration(
                                labelText: AppLocalizations.of(context)!.p2Contrasena,
                                prefixIcon: Icon(Icons.lock,),
                                
                              ),
                              style: TextStyle(color: Color(0xFFfdf7e5)),
                            ),
                
                            const SizedBox(height: 10,),
                            TextFormField(
                              controller: _controllerContrasena2,
                              obscureText: true,
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return AppLocalizations.of(context)!.p2RepiteContrasena;
                                }else if(_controllerContrasena.text!=_controllerContrasena2.text){
                                  return AppLocalizations.of(context)!.p2ContrasenaNoCoinciden;
                                }
                                return null;
                                },
                              decoration:  InputDecoration(
                                labelText: AppLocalizations.of(context)!.p2ConfirmarContrasena,
                                prefixIcon: Icon(Icons.lock,),
                                
                              ),
                              style: TextStyle(color: Color(0xFFfdf7e5)),
                            ),
                
                            const SizedBox(height: 15,),
                            ElevatedButton(onPressed: (){
                              if(_formKey.currentState!.validate()){
                                _comprobarEmail();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const IniciarSesion()));
                              }
                            }, 
                            
                            child: Text(AppLocalizations.of(context)!.p2Registrate2)),
                            SizedBox(height: 40,),
                
                             Text(AppLocalizations.of(context)!.p2TienesCuenta, style: TextStyle(color: Colors.grey),),
                            SizedBox(height: 10,),
                
                            ElevatedButton(onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const IniciarSesion()));
                              },
                              child:  Text(AppLocalizations.of(context)!.p2IniciaSesion))
                          
                          ],
                        ), 
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}

  
