import 'package:estructuratrabajofinal/clases/Usuario.dart';
import 'package:estructuratrabajofinal/dao/usuarioDAO.dart';
import 'package:estructuratrabajofinal/estructura/P1-IniciarSesion.dart';
import 'package:flutter/material.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({super.key});

  State<Registrarse> createState()=>_Principal();

}
class _Principal extends State<Registrarse>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNombre = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerTelefono = TextEditingController();
  final TextEditingController _controllerContrasena = TextEditingController();
  final TextEditingController _controllerContrasena2 = TextEditingController();

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
        const SnackBar(content: Text("Usuario creado"))
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ya hay una cuenta con ese Email"))
      );
    }
  }

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
                  const Text("REGISTRATE", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                                return "Introduce un nombre";
                              }
                              return null;
                              },
                            decoration: const InputDecoration(
                              labelText: "Nombre",
                              prefixIcon: Icon(Icons.person_off,),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 223, 222, 222))
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                              ),
                              prefixIconColor: Colors.white
                            ),
                            style: TextStyle(color: Color(0xFFfdf7e5)),
                          ),

                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: _controllerEmail,
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return "Introduce un email";
                              }
                              return null;
                              },
                            decoration: const InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.mail,),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 223, 222, 222))
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                              ),
                              prefixIconColor: Colors.white
                            ),
                            style: TextStyle(color: Color(0xFFfdf7e5)),
                          ),

                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: _controllerTelefono,
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return "Introduce un telefono";
                              }
                              return null;
                              },
                            decoration: const InputDecoration(
                              labelText: "Telefono",
                              prefixIcon: Icon(Icons.phone,),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 223, 222, 222))
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                              ),
                              prefixIconColor: Colors.white
                            ),
                            style: TextStyle(color: Color(0xFFfdf7e5)),
                          ),

                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: _controllerContrasena,
                            obscureText: true,
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return "Introduce una contraseña";
                              }
                              return null;
                              },
                            decoration: const InputDecoration(
                              labelText: "Contraseña",
                              prefixIcon: Icon(Icons.lock,),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 223, 222, 222))
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                              ),
                              prefixIconColor: Colors.white
                            ),
                            style: TextStyle(color: Color(0xFFfdf7e5)),
                          ),

                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: _controllerContrasena2,
                            obscureText: true,
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return "Repite la contraseña";
                              }else if(_controllerContrasena.text!=_controllerContrasena2.text){
                                return "Las contraseñas no coinciden";
                              }
                              return null;
                              },
                            decoration: const InputDecoration(
                              labelText: "Confirmar contraseña",
                              prefixIcon: Icon(Icons.lock,),
                              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromARGB(255, 223, 222, 222))
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                              ),
                              prefixIconColor: Colors.white
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Color(0xFFffffff),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                            textStyle: const TextStyle(fontSize: 30),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(
                                color: Colors.white,
                                width: 0.5
                              )                               
                            )
                          ),
                          child: const Text("Registrate")),
                          SizedBox(height: 40,),

                          const Text("¿Tienes cuenta?", style: TextStyle(color: Colors.grey),),
                          SizedBox(height: 10,),

                          ElevatedButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const IniciarSesion()));
                            }, style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Color(0xFFffffff),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                              textStyle: const TextStyle(fontSize: 15),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.5
                                )                               
                              )
                            ),
                            child: const Text("Inicia sesión"))
                        
                        ],
                      ), 
                    )
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
  
