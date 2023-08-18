import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/database_provider.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({
    super.key,
    required this.exp,
    
  });

  final Expense exp;
  

  @override
  Widget build(BuildContext context) {
     final provider = Provider.of<DataBaseProvider>(context,listen: false);
    return AlertDialog(
      title: Text('Удалить ${exp.title} ?'),
      content: Row(children: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, child: const Text('Не удалять')),
        const SizedBox(width: 5,),
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop(true);
          provider.deleteExpense(exp.Id, exp.category, exp.amount);
        }, child: const Text('Удалить'))
      ],),
    );
  }
}