class Product{
  int? id;
  String? name;
  String? category;

  Product({this.id,this.name, this.category});

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    category = json['category'];
  }
}