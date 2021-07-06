import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:teste_marketeasy/backend/models/produtos.dart';

class ApiController {
  static String token = "";
  //funcao que verifica se existe um token salvo no SP do android, caso exista verifica também se o tempo de validade dele não expirou.
  //retorna false caso o token não seja valido, se for carrega na variavel "token" e as requisições da api podem ser feitas tranquilamente.
  static Future<bool> validaToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? tokenExp = sp.getString("token_exp");
    if (tokenExp != null) {
      List auxDate = tokenExp.split(" ")[0].split('-');
      String auxHour = tokenExp.split(" ")[1];
      DateTime dateExp =DateTime.parse("${auxDate.reversed.join("-")} ${auxHour}");
      DateTime dateNow = DateTime.now();
      token = sp.getString("token")!;
      if (dateExp.millisecondsSinceEpoch > dateNow.millisecondsSinceEpoch)
        return true;
    }
    return false;
  }

  static Future<void> saveTokenFromJson(Map json) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("token", json['token']);
    await sp.setString("token_exp", json['tokenExpiration'].replaceAll("/", "-"));
    return;
  }

  static Future<bool> login(String user, String password) async {
    var url = Uri.parse('http://servicosflex.rpinfo.com.br:9000/v1.1/auth');
    Map<String, dynamic> body = {"usuario": user, "senha": password};
    Map<String, String> headers = {"content-Type": "application/json"};
    var response = await http.post(url, headers: headers, body: json.encode(body));
    Map jsonResponse = json.decode(response.body);
    try {
      if (jsonResponse["response"]["status"] == "ok") {
        await ApiController.saveTokenFromJson(jsonResponse["response"]);
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  static Future<List<Produtos>> getProducts() async {
    await validaToken();
    var url = Uri.parse("http://servicosflex.rpinfo.com.br:9000/v2.0/produtounidade/listaprodutos/0/unidade/83402711000110");
    var response =await http.get(url,headers: {'token':token});
    Map jsonResponse = json.decode(response.body);
    if(jsonResponse["response"]["status"]=="ok"){
      List<Produtos> produtos = (jsonResponse["response"]["produtos"] as List).map((jsonProduct) {
        return Produtos.fromJSON(jsonProduct);
      }).toList();
      return produtos;
    }else{
      return  [];
    }
  }
}
