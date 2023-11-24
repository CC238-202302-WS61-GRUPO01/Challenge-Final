import 'package:flutter/material.dart';
import 'package:app_s12/utils/dbhelper.dart';
import 'package:app_s12/models/list_item.dart';
import 'package:app_s12/models/shopping_list.dart';
import 'package:app_s12/ui/shopping_list_dialog.dart';

class ItemScreen extends StatefulWidget {
  final ShoppingList shoppingList;
  const ItemScreen(this.shoppingList);

  @override
  State<ItemScreen> createState() => _ItemScreenState(this.shoppingList);
}

class _ItemScreenState extends State<ItemScreen> {
  final ShoppingList shoppingList;
  _ItemScreenState(this.shoppingList);
  ShoppingListDialog? dialog;

  DbHelper? helper;
  List<ListItem> items=[];

  @override
  void initState(){
    dialog=ShoppingListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    helper = DbHelper();
    showData(this.shoppingList.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(shoppingList.name),
      ),
      body: ListView.builder(
        itemCount: (items!=null) ? items.length:0,
          itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(items[index].idProduct.toString()),
            subtitle: Text("Quantity: ${items[index].quantity} - Note: ${items[index].quantity}"),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){},
            ),
          );
          }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plus_one),
          onPressed: (){
            showDialog(
                context: context,
                builder: (BuildContext context) => dialog!.buildDialog(context, ShoppingList(0, '', 0), true));
          },
        )
    );
  }

  Future showData(int idList) async{
    await helper!.openDb();
    items = await helper!.getItems(idList);
    setState(() {
      items=items;
    });
  }
}
