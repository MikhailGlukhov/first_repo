import 'package:expenses_app/app.dart';
import 'package:expenses_app/models/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => DataBaseProvider(),
    child: const App(),));
  
}

