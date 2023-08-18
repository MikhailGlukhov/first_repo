import 'package:expenses_app/screens/all_expense.dart';
import 'package:expenses_app/screens/categore_screen.dart';
import 'package:expenses_app/screens/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru_RU');
  
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('en'),
        const Locale('ru')
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: CategoreScreenWidget.name,
      routes: {
        CategoreScreenWidget.name:(context) => const CategoreScreenWidget(),
        ExpenseScreenWidget.name:(context) => const ExpenseScreenWidget(),
        AllExpenseWidget.name: (context) => const AllExpenseWidget()
      },
    );
  }
}
