import 'package:flutter/material.dart';
import 'package:teste_marketeasy/backend/api_controller.dart';
import 'package:teste_marketeasy/screens/home_screen.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color primaryColor = Colors.blue[900]!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      //Verifica se existe um token, ou se o token existente é válido, para poder redirecionar para a tela correta.
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
