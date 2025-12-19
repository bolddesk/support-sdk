import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SparklineChart extends StatelessWidget {
  final List<double> data;
  final Color color;
  final double height;

  const SparklineChart({
    super.key,
    required this.data,
    this.color = Colors.deepPurple,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return SizedBox(height: height);

    final spots = List<FlSpot>.generate(
      data.length,
      (i) => FlSpot(i.toDouble(), data[i]),
    );

    final minY = data.reduce((a, b) => a < b ? a : b);
    final maxY = data.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(enabled: false),
          minX: 0,
          maxX: spots.isEmpty ? 1 : spots.last.x,
          minY: minY,
          maxY: maxY,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: color,
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                // ignore: deprecated_member_use
                color: color.withOpacity(0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
