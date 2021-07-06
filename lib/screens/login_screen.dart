import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_marketeasy/backend/api_controller.dart';
import 'package:teste_marketeasy/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _controllerUsuario = TextEditingController( );
  final _controllerSenha = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Align(
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.only(left: 10, right: 10, top: 40),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 70,
                          ),
                          radius: 50,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomText(
                            labelText: "Usuário",
                            prefixIcon: Icon(Icons.person_outline),
                            controller: _controllerUsuario),
                        CustomText(
                            labelText: "Senha",
                            prefixIcon: Icon(Icons.lock_outline),
                            //  obscureText: true,
                            controller: _controllerSenha),
                        SizedBox(
                          height: 20,
                        ),
                        isLoading == true
                            ? Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    bool isSucessul = await ApiController.login(
                                        _controllerUsuario.text,
                                        _controllerSenha.text);
                                    if (!isSucessul) {
                                      showPopUpError();
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }else{
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),));
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )),
                        SizedBox(
                          height: 70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  showPopUpError() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "AVISO",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 100,
                child: Text(
                  "Não foi possível realizar o login.",
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget CustomText(
      {required String labelText,
      required prefixIcon,
      obscureText = false,
      controller}) {
    return Container(
      margin: EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo é obrigatório*';
          }
        },
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
