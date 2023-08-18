import 'package:expenses_app/widgets/expense/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/database_provider.dart';

class AllExpenseListWidget extends StatelessWidget {
  const AllExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBaseProvider>(
      builder: (_, db,__) {
        var list = db.expenses;
        return list.isNotEmpty ? ListView.builder(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: list.length,
          itemBuilder: (_,i) => ExpenseCardWidget(exp: list[i],)) :
          const Center(child: Text('Нет Расходов'),);

      });
  }
}