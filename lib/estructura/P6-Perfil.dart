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
            title: Text("Cambia la contraseña"),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
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
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _controllerContrasenaNueva,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return "Introduce una contraseña nueva";
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
                  ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        print("actualizando contraseña");
                      }
                    }, 
                    child: Text("Actualizar contraseña")                   
                  )
                ],
              )
            )
        );
      }
    );
  }
}
