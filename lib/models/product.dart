//{"id":4643,"category":"coffee","name":"Starbucks Coffee Variety Pack, 100% Arabica","inStock":true}

class Product{
  int? id;
  String? name;
  String? category;

  Product({this.id,this.name, this.category});

  Product.toJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    category = json['category'];
  }
}