import 'package:expenses_app/widgets/expense/expense_fetcher.dart';
import 'package:flutter/material.dart';

class ExpenseScreenWidget extends StatelessWidget {
  const ExpenseScreenWidget({super.key});
  static const name = '/expense_screen';

  @override
  Widget build(BuildContext context) {
    final catgory = ModalRoute.of(context)!.settings.arguments as String;
    return  Scaffold(
      appBar: AppBar(title: const Text('Экран расходов'),
      backgroundColor: Colors.green,),
      body: ExpenesFetcherWidget(category: catgory,),
    );
  }
}

