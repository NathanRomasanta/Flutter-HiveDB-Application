
import 'package:cero/services/startup.dart';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();



  await Hive.openBox('Main');
  await Hive.openBox('Transactions');

  await Hive.openBox('Bucket1_Main');
  await Hive.openBox('Bucket1_Transactions');

  await Hive.openBox('Bucket2_Main');
  await Hive.openBox('Bucket2_Transactions');

  await Hive.openBox('Bucket3_Main');
  await Hive.openBox('Bucket3_Transactions');

  await Hive.openBox('Bucket4_Main');
  await Hive.openBox('Bucket4_Transactions');


  runApp(
    Phoenix(
      child: const App(),
    ),);
  }

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cero App',
      theme: ThemeData(
        
        
  
      ),
      home: const Startup(),
    );
  }
}


