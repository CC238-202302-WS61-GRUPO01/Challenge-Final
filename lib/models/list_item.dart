class ListItem{
  int id;
  int idList;
  int idProduct;
  String quantity;
  String note;

  ListItem(this.id, this.idList, this.idProduct, this.quantity, this.note);//, this.idProduct);
  Map<String,dynamic> toMap(){
    return{
      'id': (id==0)?null:id,
      'idList': idList,
      'idProduct':idProduct,
      'quantity':quantity,
      'note':note
    };
  }
}