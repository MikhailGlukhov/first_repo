import 'package:expenses_app/models/database_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TotalChartWidget extends StatefulWidget {
  const TotalChartWidget({super.key});

  @override
  State<TotalChartWidget> createState() => _TotalChartWidgetState();
}

class _TotalChartWidgetState extends State<TotalChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataBaseProvider>(
      builder: (_, db , __ ) {
        var list = db.category;
        var total = db.calculateTotalExpenses();
        return Row(
          children: [
             Expanded(flex: 60, child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                child: Text('Общие расходы: ${NumberFormat.currency(locale: 'ru_IN').format(total)}',textScaleFactor: 1.5,
                style: const TextStyle(fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 8,),
              ...list.map((e) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      color: Colors.primaries[list.indexOf(e)],),
                    Text(e.title),
                    SizedBox(width: 5,),
                    Text(total == 0 ? '0%': '${((e.totalAmount/total)*100).toStringAsFixed(2)}%')
                  ],
                ),
              ))],
              
            )),
            Expanded(flex: 40, child: PieChart(PieChartData(centerSpaceRadius:30,
              sections: total !=0 ? list.map((e) => PieChartSectionData(
                value: e.totalAmount,
                color: Colors.primaries[list.indexOf(e)],
                showTitle: false,
              )).toList() :
              list.map((e) => PieChartSectionData(
               
                color: Colors.primaries[list.indexOf(e)],
                showTitle: false,
              )).toList(),
            ))),
          ],
        );
      }
    );
  }
}