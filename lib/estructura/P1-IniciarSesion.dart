import 'package:estructuratrabajofinal/bd/db_helper.dart';
import 'package:estructuratrabajofinal/clases/Usuario.dart';
import 'package:flutter/material.dart';
import 'P2-Registrarse.dart';
import 'P3,1-HomeServicios.dart';
import '../dao/UsuarioDAO.dart';

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({super.key});

  State<IniciarSesion> createState()=>_Principal();
}
class _Principal extends State<IniciarSesion>{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final dbhelper= DBHelper();

  Future<void> _login() async{
    final email = _emailController.text;
    final contreasena = _contrasenaController.text;

    final users = await UsuarioDao().getUsuarios() ;

    Usuario? user; 
    for(var u in users){
      if(u.email==email && u.contrasena==contreasena){
        user = u;
        break;
      }
    }
    if(user != null){
      print("iniciando sesión");
      Usuario.usuarioActual = user;
      print(user);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeServicios()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Credenciales incorrectas"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 51, 51, 51),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),                                    
                    Text("IDENTIFÍCATE", style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 60,),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: 700,
                          child: Column(
                            children: [
                            TextFormField(                              
                              controller: _emailController,
                              validator: (value){
                                if(value == null||value.isEmpty){
                                  return "Introduce un email";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email,),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20)

                              ),
                              style: TextStyle(color: Color(0xFFfdf7e5)),

                            ),
                            const SizedBox(height: 15,),
                            TextFormField(
                              controller: _contrasenaController,
                              obscureText: true,
                              validator: (value){
                                if(value == null||value.isEmpty){
                                  return "Introduce tu contraseña";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelText: "Contraseña",
                                prefixIcon: Icon(Icons.lock),
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20)
                              ),
                              style: TextStyle(color: Color(0xFFfdf7e5)),

                            ),
                            const SizedBox(height: 20,),
                            ElevatedButton(onPressed: () {
                              if(_formKey.currentState!.validate()){
                                  _login();
                                }
                            },style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Color(0xFFffffff),
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                              textStyle: const TextStyle(fontSize: 30),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 0.5
                                )
                                                              
                              )
                            
                            ), 
                            child: const Text("Inicia sesión")),

                            Row(
                              children: [
                                const Text("Si no tienes cuenta"),
                                ElevatedButton(onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Registrarse()));
                                }, child: const Text("Registrate"))
                              ],
                            )
                          ],
                          ),
                          
                        )
                      )
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
