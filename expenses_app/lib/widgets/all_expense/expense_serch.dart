import 'package:expenses_app/models/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSerchWidget extends StatefulWidget {
  const ExpenseSerchWidget({super.key});

  @override
  State<ExpenseSerchWidget> createState() => _ExpenseSerchWidgetState();
}

class _ExpenseSerchWidgetState extends State<ExpenseSerchWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataBaseProvider>(context, listen: false);
    return TextField(
      onChanged: (value) {
        provider.serchText = value;
        
      },
      decoration: InputDecoration(
      
      labelText: 'Поиск'
    ),);
  }
}