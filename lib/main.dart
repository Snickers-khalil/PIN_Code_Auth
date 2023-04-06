import 'package:android_test_task_master/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          color: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: const IconThemeData(
            color: Colors.black,
          )
        ),
      ),
      home: const Home()
    );
  }
}