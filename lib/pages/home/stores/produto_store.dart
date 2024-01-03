import 'package:api_product/data/http/exceptions.dart';
import 'package:api_product/data/models/produto_model.dart';
import 'package:api_product/data/repositories/produto_repository.dart';
import 'package:flutter/cupertino.dart';
//gerencia os estados da tela
class ProdutoStore{
  //22
  final IProdutoRepository repository;

  //variável reativa para o loading
  //18
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  //variável reativa para o state
  //19 
  final ValueNotifier<List<ProdutoModel>> state = ValueNotifier<List<ProdutoModel>>([]);
  //variável reativa para o erro
  //20
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  //23
  ProdutoStore({required this.repository});

  //Fazer requisição ao repositorio
  //21 
  Future getProdutos() async{
    isLoading.value = true;

    try{
      //24
     final result = await repository.getProduto();
     state.value = result;
    }on NotFoundException catch (e){
      erro.value = e.message;
    }catch (e){
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
//25 - home_page.dart