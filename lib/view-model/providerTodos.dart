import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Porvider para el idioma
class ProviderTodos extends ChangeNotifier{

  Locale _idioma =Locale('es');
  
  Locale get idioma => _idioma;

  Todosprovider(){
    _cargarPref();
  }
  ///Cambia el idioma segun el string que recibe
  Future<void> cambiarIdioma(String idio) async{
    _idioma = Locale(idio);
    notifyListeners();
    final preferencia = await SharedPreferences.getInstance();
    await preferencia.setString('idioma', idio);
  }
  ///Carga las preferencias y notifica del cambio
  Future<void> _cargarPref()async{
    final preferencia =await SharedPreferences.getInstance();
    _idioma = Locale(preferencia.getString('idioma')??'es');
    notifyListeners();
  }
}