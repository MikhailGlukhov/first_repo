
import 'package:expenses_app/screens/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/expense_cat.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseCategores categores;
  const CategoryCard({super.key, required this.categores});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
         Navigator.of(context).pushNamed(
          ExpenseScreenWidget.name,
          arguments: categores.title);},
              title: Text(categores.title),
              subtitle: Text('записи: ${categores.expenseInCategores}'),
              trailing: Text(NumberFormat.currency(locale: 'ru_IN').format(categores.totalAmount)),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(categores.icon),
              ),
            );
  }
}