import 'package:expenses_app/widgets/expense_form.dart';
import 'package:flutter/material.dart';

import '../widgets/category/category_fetcher.dart';

class CategoreScreenWidget extends StatelessWidget {
  const CategoreScreenWidget({super.key});
  static const name = '/categore_screen'; //rote name

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Категории расходов'),
        backgroundColor: Colors.green,
      ),
      body:  const CategoryFetcherWidget(),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
      backgroundColor: Colors.green,
        onPressed: (){
          showModalBottomSheet(
            context: context, 
            isScrollControlled: true,
            builder: (context) => const ExpenseFormWidget() );
        }),
    );
  }
}

