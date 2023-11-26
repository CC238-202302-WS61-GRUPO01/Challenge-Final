class Product{
  int? id;
  String? category;
  String? name;

  Product({this.id, this.category,this.name});

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    category = json['category'];
    name = json['name'];
  }
}