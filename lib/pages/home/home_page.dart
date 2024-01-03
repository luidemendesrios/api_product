import 'package:api_product/data/http/http_client.dart';
import 'package:api_product/data/repositories/produto_repository.dart';
import 'package:api_product/pages/home/stores/produto_store.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //26 
  final ProdutoStore store = ProdutoStore(repository: ProdutoRepository(client: HttpClient(),
  ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //27
    store.getProdutos(); //inicializa a tela buscando os produtos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Consumo de APIs',
        style: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold),
        ),
      ),
      //28
      body: //3 Container(), precisa usar um widget para gerenciar a store
      AnimatedBuilder(animation: Listenable.merge([ //lista de variáveis que são reativas
        store.isLoading,//monitorar os 3 estados de resposta da API 
        store.erro,
        store.state,
      ]),
      builder: (context, child) {
        //verificar o estado que esta sendo alterado no store
        if(store.isLoading.value){ //se o isLoanding for verdadeiro mostrar o circularProgressIndicator
          return const Center(child: CircularProgressIndicator());
        }else if(store.erro.value.isNotEmpty){ //se não for vazio exibir na tela a msg do erro
          return Center(
            child: Text(store.erro.value,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
            ),
          );
        }
        if(store.state.value.isEmpty){//Se a mensagem for vazia mostrar a msg abaixo na tela
          return const Center(
            child: Text(
              'Nenhum item na lista',
              style: TextStyle(
                 color: Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              ),
            ),
          );
        }else {
          return ListView.separated( //se existir item na lista ele exibe o listView.separated
            itemBuilder: (_, index) {
              final item = store.state.value[index];
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item.thumbnail, //imagem do produto
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.title, //titulo da lista de produto
                      style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                    ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('R\$ ${item.price}', //preço do produto
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        ),
                        const SizedBox(height: 4,),
                        Text(
                          item.description, //descrição do produto
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 32,
            ),
            padding: const EdgeInsets.all(16),
            itemCount: store.state.value.length //tamanho de item da lista
            );
        }
      },
      )
    );
  }
}