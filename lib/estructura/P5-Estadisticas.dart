import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
class Estadisticas extends StatefulWidget {
  const Estadisticas({super.key});
  State <Estadisticas> createState()=> _principal();
}
class _principal extends State<Estadisticas>{
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
        BarChart(
          BarChartData(
            barGroups: [
              BarChartGroupData(x: 1, barRods: [
                BarChartRodData(toY: Tarea.tareasCompletadas.toDouble(), color: Colors.green),
                BarChartRodData(toY: Tarea.tareasNoCompletas.toDouble(), color: Colors.red)
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(toY: 12, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 5, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 6, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 7, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 8, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 9, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 10, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 11, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
              BarChartGroupData(x: 12, barRods: [
                BarChartRodData(toY: 5, color: Colors.green),
                BarChartRodData(toY: 3, color: Colors.red)
              ]),
            ],
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 1:
                        return const Text('Ene');
                       
                      case 2:
                        return const Text('Feb');
                      case 3:
                        return const Text('Mar');
                      case 4:
                        return const Text('Abr');
                      case 5:
                        return const Text('May');
                      case 6:
                        return const Text('Jun');
                      case 7:
                        return const Text('Jul');
                      case 8:
                        return const Text('Ago');
                      case 9:
                        return const Text('Sep');
                      case 10:
                        return const Text('Oct');
                      case 11:
                        return const Text('Nov');
                      case 12:
                        return const Text('Dic');
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
