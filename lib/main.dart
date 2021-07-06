import 'package:flutter/material.dart';
import 'package:teste_marketeasy/backend/api_controller.dart';
import 'package:teste_marketeasy/screens/home_screen.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color primaryColor = Colors.blue[900]!;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: FutureBuilder(
        future: ApiController.validaToken(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data==false){
             return LoginScreen();
            }else{
              return HomeScreen();
            }
          }else{
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          }
        },
      ),
    );
  }
}
