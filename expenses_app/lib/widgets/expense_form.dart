import 'package:expenses_app/files/icons.dart';
import 'package:expenses_app/models/database_provider.dart';
import 'package:expenses_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ExpenseFormWidget extends StatefulWidget {
  const ExpenseFormWidget({super.key});

  @override
  State<ExpenseFormWidget> createState() => _ExpenseFormWidgetState();
}

class _ExpenseFormWidgetState extends State<ExpenseFormWidget> {

 
  final _title = TextEditingController();
  final _amount = TextEditingController();
  
  DateTime? _date;
  String _initialValue = 'Другое';

  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      locale: const Locale('ru','RU'),
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2023), 
      lastDate: DateTime.now());

      if (pickedDate !=null) {
        setState(() {
          _date = pickedDate;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataBaseProvider>(context, listen: false);
    return  Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.all(20),
      child:  SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: _title,
            decoration: const InputDecoration(
              labelText: 'Название'),),
            const SizedBox(height: 20,),
            TextField(controller: _amount, 
            keyboardType: TextInputType.number, 
            decoration: const InputDecoration(labelText: 'Сумма'),),
            const SizedBox(height: 20,),
            Row(children: [
              Expanded(child:  Text(_date != null ? DateFormat('MMMM dd, yyyy').format(_date!) :'Дата')),
              IconButton(onPressed: () => _pickDate(), icon: const Icon(Icons.calendar_month))

            ],),
            const SizedBox(height: 20,),
            Row(children: [
              const Expanded(child: Text('Категория')),
              Expanded(child: DropdownButton(
                items: icons.keys.map((e) => DropdownMenuItem(value: e, child: Text(e),)).toList(),
                value: _initialValue, 
                onChanged: (newValue) {
                  setState(() {
                    _initialValue = newValue!;
                  });


              })
              )],
              ),
              const SizedBox(height: 20,),
              ElevatedButton.icon(onPressed: (){
                if(_title.text != '' && _amount.text != '') {
                  final file = Expense(
                    Id: 0, 
                    title: _title.text, 
                    amount: double.parse(_amount.text), 
                    date: _date !=null ? _date!: DateTime.now(), 
                    category: _initialValue);
                    provider.addExpense(file);
                    Navigator.of(context).pop();
                }
              },
               icon: Icon(Icons.add),
                label: Text('Добавить расходы'))
          ],
        ),
      ),
    );
  }
}