import 'package:expenses_app/files/icons.dart';
import 'package:flutter/material.dart';

class ExpenseCategores{
  final String title;
  int expenseInCategores = 0;
  double totalAmount = 0.0;
  final IconData icon;

  ExpenseCategores({
    required this.title,
    required this.icon,
    required this.expenseInCategores,
    required this.totalAmount});

    Map<String, dynamic> toMap() => {
      'title': title,
      'expenseInCategores': expenseInCategores,
      'totalAmount': totalAmount.toString(),
      
    };
    
    factory ExpenseCategores.fromString(Map<String,dynamic> value) =>
     ExpenseCategores(title: value['title'],
      icon: icons[value['title']]!,
      expenseInCategores: value['expenseInCategores'],
      totalAmount: double.parse(value['totalAmount']));
}