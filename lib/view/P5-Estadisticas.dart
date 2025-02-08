import 'package:estructuratrabajofinal/view-model/CitasDAO.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Estadisticas extends StatefulWidget {
  const Estadisticas({super.key});
  State <Estadisticas> createState()=> _Estadisticas();

}
///Estadisticas de las citas que has ido en un año
class _Estadisticas extends State<Estadisticas>{
  late Future<Map<int, Map<String, int>>> _datosCitas;

  @override
  void initState() {
    super.initState();
    _datosCitas = _cargarCitas();
  }
  ///Funcion para que se inicialicen todos los meses del año independientemente si tengan citas o no
  Future<Map<int, Map<String, int>>> _cargarCitas() async {
    final datos = await CitasDao().obtenerEstadisticasCitas();

    for (int mes = 1; mes <= 12; mes++) {
      datos.putIfAbsent(mes, () => {'Acudido': 0, 'No acudido': 0});
    }
    return datos;
  }
  ///Obtiene el maximo verticalmente de citas y lo añade 2 para que haya margen
  double _obtenerMaximoY(List<BarChartGroupData> barGroups) {
    double maxY = 0;
    for (var group in barGroups) {
      for (var rod in group.barRods) {
        if (rod.toY > maxY) maxY = rod.toY;
      }
    }
    return maxY + 2; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5a5a5a),
      body: FutureBuilder(
        future: _datosCitas, 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            ); 
          }
          if(snapshot.hasError){
            return Center(
              child: Text("${AppLocalizations.of(context)!.p5Error} ${snapshot.error}"),
            );
          }

          final datos = snapshot.data?? {};

          final barGroups = List.generate(12, (index) {
            int mes = index + 1;
            int acudido = datos[mes]?['Acudido'] ?? 0;
            int noAcudido = datos[mes]?['No acudido'] ?? 0;

            return BarChartGroupData(
              x: mes,
              barRods: [
                BarChartRodData(toY: acudido.toDouble(), color: Colors.green),
                BarChartRodData(toY: noAcudido.toDouble(), color: Colors.red),
              ],
            );
          });
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                  BarChart(
                    BarChartData(
                      barGroups: barGroups,
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(value.toInt().toString(), style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),);
                            },
                              reservedSize: 30
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget:(value, meta) {
                              const meses = [
                                'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 
                                'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
                              ];
                              if(value >= 1 && value <= 12){
                                return Text(meses[(value.toInt()- 1).clamp(0, 11)],style: TextStyle(color: Colors.white),); 
                              }else{
                                return const Text('');
                              }
                            },
                            reservedSize: 32,
                            
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(value.toInt().toString(), style: TextStyle(fontSize: 15,color: Colors.white),);
                            },
                            interval: 1,
                            reservedSize: 30
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false
                            
                          )
                        )
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border:  Border.all(color: Colors.black, width: 1)
                      ),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _obtenerMaximoY(barGroups)
                    
                    ),
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    leyendaInfo(Colors.green, AppLocalizations.of(context)!.p5CitaAcudida),
                    const SizedBox(width: 40,),
                    leyendaInfo(Colors.red, AppLocalizations.of(context)!.p5CitaNoAcudida)
                  ],
                ),
              ),
              const SizedBox(height: 10,)
            ],
          );
        }
      )
    );
  }
  Widget leyendaInfo(Color color, String texto){
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        Text(texto, style: const TextStyle(fontSize: 13,color: Colors.white),),
      ],
    );
  }
}
