import 'package:flutter/material.dart';
import 'package:flutter_application_todo/navigation/main_navigation.dart';



class MyApp extends StatelessWidget {
   static final mainNavigation = MainNavigation();
  const MyApp({super.key});
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: mainNavigation.routes,
       initialRoute: mainNavigation.initialRoute,
       onGenerateRoute: mainNavigation.onGenerateRoute,
      theme: ThemeData(
        
        primarySwatch: Colors.blue
      ),
     
    );
  }
}