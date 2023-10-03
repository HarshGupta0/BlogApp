import 'package:flutter/material.dart';
import 'package:subspace/view/Home.dart';
import 'package:subspace/view/spalshScreen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showingSplash=true;
  LoadHome(){
    Future.delayed(Duration(seconds: 5),(){
      setState(() {
        showingSplash=false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    LoadHome();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:showingSplash ? SplashScreen() : Home(),
    );
  }
}
