import 'package:flutter/material.dart';
import 'LoadingPage.dart';
import 'page1.dart';
import 'sqldb.dart';


void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  final SqlDb sqlDb = SqlDb();
  await sqlDb.db;
  runApp(MaterialApp(
  initialRoute: '/loadingPage',
  routes: {
    '/loadingPage': (context) => const LoadingPage(),
    '/page1' : (context) => const Page1(),
  },
  ));
}
