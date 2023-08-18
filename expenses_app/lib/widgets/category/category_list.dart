
import 'package:expenses_app/widgets/category/category_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/database_provider.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBaseProvider>(
      builder: (context, db, child) {
        var list = db.category;
        return ListView.builder(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: list.length,
          itemBuilder: (context, i) => CategoryCard(categores: list[i])
            
              

          );
        
      },
    );
  }
}
