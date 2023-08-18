import 'package:expenses_app/models/database_provider.dart';
import 'package:expenses_app/widgets/all_expense/all_expense_list.dart';
import 'package:expenses_app/widgets/all_expense/expense_serch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllExpenseFetcherWidget extends StatefulWidget {
  const AllExpenseFetcherWidget({super.key});

  @override
  State<AllExpenseFetcherWidget> createState() => _AllExpenseFetcherWidgetState();
}

class _AllExpenseFetcherWidgetState extends State<AllExpenseFetcherWidget> {
  late Future _allExpenseList;
  Future _getAllExpense() async{
    final provide = Provider.of<DataBaseProvider>(context,listen: false);
    return await provide.fetchAllExpense();
  } 
  @override
  void initState() {
   
    super.initState();
    _allExpenseList = _getAllExpense();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _allExpenseList,
      builder:(_, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }else{
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                ExpenseSerchWidget(),
               Expanded(child:  AllExpenseListWidget())
              ],),
            );
          }


        }else{return Center(child: CircularProgressIndicator(),);}
      } );
  }
}


