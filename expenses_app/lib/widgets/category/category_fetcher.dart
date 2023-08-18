import 'package:expenses_app/models/database_provider.dart';
import 'package:expenses_app/screens/all_expense.dart';
import 'package:expenses_app/widgets/category/category_list.dart';
import 'package:expenses_app/widgets/category/chart_total.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CategoryFetcherWidget extends StatefulWidget {
  const CategoryFetcherWidget({super.key});

  @override
  State<CategoryFetcherWidget> createState() => _CategoryFetcherWidgetState();
 
}

class _CategoryFetcherWidgetState extends State<CategoryFetcherWidget> {
   late Future _categoryList;
  Future _getCategoryList() async{
    final provider = Provider.of<DataBaseProvider>(context,listen: false );
    return await provider.fetchCategory();
  }
@override
  void initState() {
   
    super.initState();
    _categoryList = _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _categoryList,
      builder: (_, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return   Padding(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: Column(
                children:  [
                  const SizedBox(
                  height: 300,
                  child: TotalChartWidget(),),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text('Расходы',
                    style: TextStyle(fontWeight: FontWeight.bold),),
                    TextButton(onPressed: () {
                      Navigator.of(context).pushNamed(AllExpenseWidget.name);
                    }, child: Text('Посмотреть все'))
                  ],),
                  const Expanded(child:  CategoryListWidget()),
                ],
              ),
            );
          }

        }
        else{
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}

