class Produtos{
  int codigoInterno;
  String descricao;
  double valorUnitario;
  String codigoBarras;

  Produtos({required this.codigoInterno, required this.descricao, required this.valorUnitario,required this.codigoBarras});

  factory Produtos.fromJSON(Map json){
    return Produtos(
      codigoInterno: json['Codigo'] ,
      descricao: json['Descricao'],
      valorUnitario: json['Preco'],
      codigoBarras: json['CodigoBarras'],
    );
  }
  @override
  String toString() {
    return 'Produtos{codigoInterno: $codigoInterno, descricao: $descricao, valorUnitario: $valorUnitario, codigoBarras: $codigoBarras}';
  }
}