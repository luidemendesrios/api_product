class ProdutoModel {
  final String title;
  final String description;
  final double price;
  final double rating;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  ProdutoModel({
   required this.title, 
   required this.description, 
   required this.price, 
   required this.rating,
   required this.brand, 
   required this.category, 
   required this.thumbnail, 
   required this.images});
  /*
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'price': price});
    result.addAll({'rating': rating});
    result.addAll({'brand': brand});
    result.addAll({'category': category});
    result.addAll({'thumbnail': thumbnail});
    result.addAll({'images': images});
  
    return result;
  } */

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] * 1.0 ?? '',  //o recurso * 1.0 é para transformar em double
      rating: map['rating'] * 1.0 ?? '',
      brand: map['brand'] ?? '',
      category: map['category'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      images: List<String>.from(map['images']),
    );
  }
  /*
  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) => ProdutoModel.fromMap(json.decode(source)); */
} 

//Obs: Agora precisa pegar os dados em json da API e transformar para um map em dart

