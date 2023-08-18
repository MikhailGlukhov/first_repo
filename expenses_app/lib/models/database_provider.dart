

import 'dart:core';

import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/models/expense_cat.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../files/icons.dart';


class DataBaseProvider with ChangeNotifier{
  String _serchText = '';
  String get serchText => _serchText;
  set serchText(String value) {
    _serchText = value;
    notifyListeners();
  }

  List<ExpenseCategores> _category = [];
  List<ExpenseCategores> get category => _category;
  List<Expense> _expenses = [];
  List<Expense> get expenses {

    return _serchText != '' ? _expenses.where((element) => element.title.toLowerCase().contains(_serchText.toLowerCase())).toList()
    : _expenses;
  }


  Database? _dataBase;
  Future<Database> get database async{
    final dbDirectory = await getDatabasesPath();
    const dbName = 'extense.db';
    final path = join(dbDirectory,dbName);

    _dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb);

      return _dataBase!;
  } 
  static const cTable = 'categoryTable';
  static const eTable = 'expenseTable';
  Future<void> _createDb(Database db, int version) async{
    await db.transaction((txn) async {
      await txn.execute('''CREATE TABLE $cTable(
        title TEXT,
        expenseInCategores INTEGER,
        totalAmount TEXT
      )''');

      await txn.execute('''CREATE TABLE $eTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        amount TEXT,
        date TEXT,
        category TEXT
      )''');

      for(int i=0; i < icons.keys.length; i++ ){
        await txn.insert(cTable, {
          'title': icons.keys.toList()[i],
          'expenseInCategores': 0,
          'totalAmount': (0.0).toString(),
        });
      }
    } );

  }

  Future<List<ExpenseCategores>> fetchCategory() async{
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(cTable).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);

        List<ExpenseCategores> nList = List.generate(converted.length,
         (index) => ExpenseCategores.fromString(converted[index]));

         _category = nList;
         return _category;
      });
    }); 
  }

  Future<void> updateCategory(String category, int nExpenseInCategores, double nTotalAmount) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update(cTable, {
        'expenseInCategores': nExpenseInCategores,
        'totalAmount': nTotalAmount.toString(),
      }, where: 'title == ?',
      whereArgs: [category]).then((value){
        var file = _category.firstWhere((element) => element.title == category);
        file.expenseInCategores = nExpenseInCategores;
        file.totalAmount = nTotalAmount;
        notifyListeners();

      });

    });
  }

  Future<void> addExpense(Expense exp) async {
    final db = await database;
    await db.transaction((txn)async{
      await txn.insert
      (eTable, 
      exp.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace).then((generatedId){
        final file = Expense(
          Id: generatedId, 
          title: exp.title, 
          amount: exp.amount, 
          date: exp.date, 
          category: exp.category);

          _expenses.add(file);
          notifyListeners();

          var ex = findCategory(exp.category);

         
          updateCategory(exp.category, ex.expenseInCategores + 1 , ex.totalAmount + exp.amount);

      });

    });
  }

  Future<void> deleteExpense(int expId, String category, double amount) async{
    final db = await database;
    await db.transaction((txn) async{
      await txn.delete(eTable, where: 'id == ?', whereArgs: [expId]).then((value) {
        _expenses.removeWhere((element) => element.Id == expId);
        notifyListeners();
        var ex =  findCategory(category);
                   
          updateCategory(category, ex.expenseInCategores - 1 , ex.totalAmount - amount);

      });

    });

  }



  Future<List<Expense>> fetchExpenses(String category) async{
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(eTable, where: 'category == ?' , whereArgs:  [category]).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        List<Expense> nList = List.generate(converted.length, (index) => Expense.toString(converted[index]));
        _expenses = nList;
        return _expenses;
      });

    });
  }

  Future<List<Expense>> fetchAllExpense() async {
    final db = await database;
    return await db.transaction((txn) async{
      return await txn.query(eTable).then((data) {
        final converted = List<Map<String, dynamic>>.from(data);
        List<Expense> nList = List.generate(converted.length, (index) => Expense.toString(converted[index]));
        _expenses = nList;
        return _expenses;

      });

    }); 
  }

  ExpenseCategores findCategory(String title){
    return _category.firstWhere((element) => element.title == title);

  } 
  Map<String, dynamic> calculateAndAmountExpenseInCategory(String category){
    double total = 0.0;
    var list  = _expenses.where((element) => element.category == category);
    for(final i in list){
      total += i.amount;
    }
    return {'expenseInCategores': list.length, 'totalAmount': total};
  }

  double calculateTotalExpenses() {
  return _category.fold(0.0, (previousValue, element) => previousValue + element.totalAmount);
}

List<Map<String, dynamic>> calculateWeekExpense(){
  List<Map<String, dynamic>> date = [];
  
  for(int i=0; i<7; i++){
    double total = 0.0;
    final weekDay = DateTime.now().subtract(Duration(days: i));

    for(int j =0; j< _expenses.length; j++){
      if(_expenses[j].date.year == weekDay.year &&
      _expenses[j].date.month == weekDay.month &&
      _expenses[j].date.day == weekDay.day){
        total += _expenses[j].amount;
      }
    }
    date.add({'day': weekDay, 'amount': total});

  }
  return date;
}
}
