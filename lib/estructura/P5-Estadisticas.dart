import 'package:estructuratrabajofinal/dao/CitasDAO.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Estadisticas extends StatefulWidget {
  const Estadisticas({super.key});
  State <Estadisticas> createState()=> _principal();

}
class _principal extends State<Estadisticas>{
  late Future<Map<int, Map<String, int>>> _datosCitas;

  @override
  void initState() {
    super.initState();
    _datosCitas = _cargarCitas();
  }

  Future<Map<int, Map<String, int>>> _cargarCitas() async {
    final datos = await CitasDao().obtenerEstadisticasCitas();

    for (int mes = 1; mes <= 12; mes++) {
      datos.putIfAbsent(mes, () => {'Acudido': 0, 'No acudido': 0});
    }
    return datos;
  }

  double _obtenerMaximoY(List<BarChartGroupData> barGroups) {
    double maxY = 0;
    for (var group in barGroups) {
      for (var rod in group.barRods) {
        if (rod.toY > maxY) maxY = rod.toY;
      }
    }
    return maxY + 2; //margen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
              child: Text("Error ${snapshot.error}"),
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
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget:(value, meta) {
                              const meses = [
                                'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 
                                'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
                              ];
                              if(value >= 1 && value <= 12){
                                return Text(meses[(value.toInt()- 1).clamp(0, 11)]); 
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
                              return Text(value.toInt().toString(), style: TextStyle(fontSize: 15),);
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
                    leyendaInfo(Colors.green, " Citas acudidas"),
                    const SizedBox(width: 40,),
                    leyendaInfo(Colors.red, " Citas no acudidas ")
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
        Text(texto, style: const TextStyle(fontSize: 13),),
      ],
    );
  }
}
