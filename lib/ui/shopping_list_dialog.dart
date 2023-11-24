import 'package:flutter/material.dart';
import 'package:app_s12/utils/dbhelper.dart';
import 'package:app_s12/models/shopping_list.dart';

class ShoppingListDialog{
  final txtName=TextEditingController();
  final txtPriority=TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew){
    DbHelper helper=DbHelper();
    if(!isNew){
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }
    else{
      txtName.text = "";
      txtPriority.text = "";
    }

    return AlertDialog(
      title: Text((isNew) ? "New shopping list":"Edit shopping list"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                hintText: "Shopping list name"
              ),
            ),
            TextField(
              controller: txtPriority,
              decoration: InputDecoration(
                  hintText: "Shopping list priority"
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  list.name=txtName.text;
                  list.priority=int.parse(txtPriority.text);
                  helper.insertList(list);
                  Navigator.pop(context);
                },
                child: Text("Save")
            )
          ],
        ),
      ),
    );
  }
}