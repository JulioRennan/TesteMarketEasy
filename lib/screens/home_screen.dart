import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_marketeasy/backend/api_controller.dart';
import 'package:teste_marketeasy/backend/models/produtos.dart';
import 'package:teste_marketeasy/shared_components/list_view_products.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<Produtos> produtos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        child: isLoading == false
            ? Icon(Icons.refresh_outlined)
            : Container(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  strokeWidth: 2,
                ),
              ),
        onPressed: isLoading == false
            ? () async {
                setState(() {
                  isLoading = true;
                });
                await Future.delayed(Duration(seconds: 2));
                setState(() {
                  isLoading = false;
                });
              }
            : null,
      ),
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              Spacer(),
              Container(
                width: 40,
                height: 50,
                child: Card(
                  child: IconButton(
                      onPressed: () {
                        logout(context);
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
              ),
            ],
          )),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: FutureBuilder(
            future: ApiController.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                produtos = snapshot.data as List<Produtos>;
                if (isLoading == true) {
                  return Loading();
                } else {
                  return Card(
                    color: Theme.of(context).primaryColor,
                    elevation: 5,
                    child: ListViewProducts(produtos),
                    margin: EdgeInsets.all(20),
                  );
                }
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
    );
  }
  Widget Loading(){

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Carregando produtos..."),
          Container(margin: EdgeInsets.only(top: 10),width: 100, child: LinearProgressIndicator(color: Theme.of(context).primaryColor,))
        ],
      ),
    );
  }
  Future logout(context) async {
    bool isSair = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Deseja mesmo realizar o logout?",
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Sair")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Cancelar"))
          ],
        );
      },
    );
    if (isSair) {
      await (await SharedPreferences.getInstance()).clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  Future refreshList() async {
    produtos = await ApiController.getProducts();
    setState(() {});
  }
}
