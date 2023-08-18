import 'package:expenses_app/files/icons.dart';

import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/expense/confirm_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ExpenseCardWidget extends StatelessWidget {
  final Expense exp;
  const ExpenseCardWidget({super.key, required this.exp});

  @override
  Widget build(BuildContext context) {
   
    return Dismissible(
      key: ValueKey(exp.Id),
      confirmDismiss: (_) async {
        showDialog(context: context, builder: (_) => ConfirmBox(exp: exp));
      },
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icons[exp.category]),
        ),
        title: Text(exp.title),
        subtitle: Text(DateFormat('MMMM dd ,yyyy','ru_RU').format(exp.date)),
        trailing: Text(NumberFormat.currency(locale: 'ru_IN').format(exp.amount)),
      ),
    );
  }
}

