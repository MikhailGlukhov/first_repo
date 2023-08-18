import 'package:expenses_app/models/database_provider.dart';
import 'package:expenses_app/widgets/expense/expense_chart.dart';
import 'package:expenses_app/widgets/expense/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ExpenesFetcherWidget extends StatefulWidget {
  final String category;
  const ExpenesFetcherWidget({super.key, required this.category});

  @override
  State<ExpenesFetcherWidget> createState() => _ExpenesFetcherWidgetState();
}

class _ExpenesFetcherWidgetState extends State<ExpenesFetcherWidget> {
  late Future _expenseList;
  Future _getExpenseList() async{
    final provider = Provider.of<DataBaseProvider>(context,listen: false);
    return await provider.fetchExpenses(widget.category);
  }

  @override
  void initState() {
 
    super.initState();
    _expenseList = _getExpenseList();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _expenseList,
      builder: (context, snapshot) {
        
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return  Center(child: Text(snapshot.error.toString()),);
          }else{
            return  Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children:  [
                  SizedBox(height: 250,child: ExpenseChartWidget(category: widget.category,),),
                   const Expanded(child: ExpenseListWidget()),
                ],
              ),
            );
          }
        }
        else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },);
  }
}