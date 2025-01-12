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
    return Scaffold(
        appBar: AppBar(title: Text("Registrate"),centerTitle: true,),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 100,),
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
                    border: OutlineInputBorder()
                  ),
                ),

                const SizedBox(height: 15,),
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
                    border: OutlineInputBorder()
                  ),
                ),

                const SizedBox(height: 15,),
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
                    border: OutlineInputBorder()
                  ),
                ),

                const SizedBox(height: 15,),
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
                    border: OutlineInputBorder()
                  ),
                ),

                const SizedBox(height: 15,),
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
                    border: OutlineInputBorder()
                  ),
                ),

                const SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    _comprobarEmail();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const IniciarSesion()));
                  }
                }, child: const Text("Registrarse")),
              ],
            ),
          )
        )
    );
  }
}
  
