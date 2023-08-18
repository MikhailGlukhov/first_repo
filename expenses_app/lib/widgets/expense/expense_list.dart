import 'package:expenses_app/models/database_provider.dart';

import 'package:expenses_app/widgets/expense/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBaseProvider>(
      builder:(_, db,__) {
        var exList = db.expenses;
        return exList.isNotEmpty ? ListView.builder(physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount:  exList.length,
          itemBuilder: (context, i) => ExpenseCardWidget(exp: exList[i],)
        ): const Center(child: Text('Нет Расходов'));
      });
  }
}

