import 'dart:convert';

import 'package:api_product/data/http/exceptions.dart';
import 'package:api_product/data/http/http_client.dart';

import '../models/produto_model.dart';

abstract class IProdutoRepository{
  Future<List<ProdutoModel>> getProduto(); //função getProduto retorna uma lista de ProdutoModel no Futuro
}

class ProdutoRepository implements IProdutoRepository{
  //5
  final IHttpClient client;
  //6
  ProdutoRepository({required this.client});

  @override
  Future<List<ProdutoModel>> getProduto() async{
   //14
  final response = await client.get(url: 'https://dummyjson.com/product');

  //15
  if(response.statusCode == 200){
    final List<ProdutoModel> produtos = [];
    //A resposta vem no formato de string então tem que se transformar em um map
    final body = jsonDecode(response.body);
    //pecorrer a lista de itens e adicionar em produtos
    body['products'].map((item){
      final ProdutoModel produto = ProdutoModel.fromMap(item);
      produtos.add(produto);
    }).toList();
    return produtos;
  } else if(response.statusCode == 404){  //criar o http/exceptions.dart
    throw    NotFoundException('A url informada não é válida');//10
  }else{
    throw Exception('Não foi possível carregar os produtos');
  } //17 - criar a pasta pages/home/stores- produto_store.dart
  }


}