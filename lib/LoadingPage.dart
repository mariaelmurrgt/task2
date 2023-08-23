import 'package:flutter/material.dart';
import 'sqldb.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds : 2), () { 
      navigateToMain();
    });
  }

  void navigateToMain(){
    Navigator.pushNamedAndRemoveUntil(context, '/page1', (route) => false);

  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/image2.png',
        ),
      ),
    );
  }
}