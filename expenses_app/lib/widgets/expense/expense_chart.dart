

import 'package:expenses_app/models/database_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class ExpenseChartWidget extends StatefulWidget {
  final String category;
  const ExpenseChartWidget({super.key, required this.category});

  @override
  State<ExpenseChartWidget> createState() => _ExpenseChartWidgetState();
}

class _ExpenseChartWidgetState extends State<ExpenseChartWidget> {
  @override
  Widget build(BuildContext context) {
    
    return Consumer<DataBaseProvider>(
      builder: (_, db, __) {
        var maxY = db.calculateAndAmountExpenseInCategory(widget.category)['totalAmount'];
        var list = db.calculateWeekExpense().reversed.toList();
        return BarChart(
          BarChartData(
            minY: 0,
            maxY: maxY,
            barGroups: [
              
              ...list.map((e) => BarChartGroupData(x: list.indexOf(e),
              barRods: [BarChartRodData(toY: e['amount'], width: 20, borderRadius: BorderRadius.zero),]
              )
              )
            ],
            titlesData: FlTitlesData(
              topTitles: AxisTitles(
                drawBelowEverything: true
              ),
              leftTitles: AxisTitles(
                drawBelowEverything: true
              ),
              rightTitles: AxisTitles(
                drawBelowEverything: true
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) => (Text(DateFormat.E('ru_RU').format(list[value.toInt()]['day']))),
                )
              )
            )

        ));
      }
    );
  }
}