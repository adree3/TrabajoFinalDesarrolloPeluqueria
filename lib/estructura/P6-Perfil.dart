import 'package:estructuratrabajofinal/clases/Usuario.dart';
import 'package:estructuratrabajofinal/dao/UsuarioDAO.dart';
import 'package:estructuratrabajofinal/estructura/P1-IniciarSesion.dart';
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
      body: Center(
        child: Column(
          children: [
            const Text("imagen"),
            SizedBox(height: 20,),
            Form(
              child: Column(
                children: [
                  ElevatedButton(onPressed: (){_dialogo(context);}, child: Text("Cambiar la contraseña"))
                ],
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const IniciarSesion()));
              },
              child: const Text("Cerrar Sesion"),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Eliminar Cuenta"),
            ),
          ],
        ),
      )
    );
  }
  void _dialogo(BuildContext context){
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _controllerContrasenaActual = TextEditingController();
    final TextEditingController _controllerContrasenaNueva = TextEditingController();
    final TextEditingController _controllerContrasenaNueva2 = TextEditingController();

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Row(
              children: [
                Icon(Icons.lock, color: Colors.blue),
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
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Introduce tu contraseña actual";
                      }

                      return null;

                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Introduce tu contraseña actual"
                    ),
                  ),
                  SizedBox(height: 15,),
                  Divider(),
                  SizedBox(height: 15,),
                  TextFormField(
                    obscureText: true,
                    controller: _controllerContrasenaNueva,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Introduce una contraseña nueva";
                      }
                      if(_controllerContrasenaActual.text== value){
                        return "No puedes introducir la misma contraseña que la actual";
                      }
                      return null;
                      
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Introduce una contraseña nueva"
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    obscureText: true,
                    controller: _controllerContrasenaNueva2,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Repite la contraseña nueva";
                      }
                      if(_controllerContrasenaNueva.text!=value){
                        return "Las contraseñas nuevas tienen que coincidir";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Repite la contraseña nueva"
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        Usuario? user = Usuario.usuarioActual; 
                        print(user);
                        if(_formKey.currentState!.validate()){
                          if(await UsuarioDao().comprobarUsuario(user!.email, _controllerContrasenaActual.text)){
                            if(await UsuarioDao().actualizarUsuarioContrasena(user.id!, _controllerContrasenaNueva.text) != 0){
                              Usuario.usuarioActual = await UsuarioDao().obtenerUsuarioPorId(user.id!);
                              print("Contraseña actualizada");                              
                              print(Usuario.usuarioActual);
                              Navigator.of(context).pop();
                            }
                          }
                        }
                      }, 
                      child: Text("Actualizar contraseña"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),            
                      )
                    ),
                  )
                ],
              )
            ),
          )
        );
      }
    );
  }
}
