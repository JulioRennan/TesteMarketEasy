import 'package:flutter/material.dart';
import 'package:teste_marketeasy/backend/models/produtos.dart';

class ListViewProducts extends StatelessWidget {
  List<Produtos> produtos = [];

  ListViewProducts(this.produtos);

  @override
  Widget build(BuildContext context) {
    if (produtos.length == 0) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.remove_shopping_cart_outlined,
              color: Colors.white,
              size: 50,
            ),
            Text(
              "Nenhum produto foi encotrado nessa consulta.",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          Produtos p = produtos[index];
          return Card(
            elevation: 4,

            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                      child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${(index+1).toString()} -) ${p.descricao}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Cod. interno: ${p.codigoInterno.toString()}",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w800),),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 5),
                                padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  "images/barcode.png",
                                  width: 20,
                                )),
                            Text("${p.codigoBarras}",style: TextStyle(fontWeight: FontWeight.w600),)
                          ],
                        )
                      ],
                    ),
                  )),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.grey,
                    margin: EdgeInsets.only(left: 5, right: 5),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.green,
                      ),
                      Text(
                        " ${p.valorUnitario.toStringAsFixed(2)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
