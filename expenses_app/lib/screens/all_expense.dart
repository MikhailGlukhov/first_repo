import 'package:expenses_app/widgets/all_expense/all_expense_fetcher.dart';
import 'package:flutter/material.dart';

class AllExpenseWidget extends StatefulWidget {
  const AllExpenseWidget({super.key});
  static const name = '/all_expense';

  @override
  State<AllExpenseWidget> createState() => _AllExpenseWidgetState();
}

class _AllExpenseWidgetState extends State<AllExpenseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: 
    AppBar(backgroundColor: Colors.green,
      title: const Text('Все расходы'),
    ),
    body: const AllExpenseFetcherWidget());
  }
}

