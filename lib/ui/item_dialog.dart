import 'package:app_s12/models/list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dbhelper.dart';

class ItemDialog{
  final txtQuantity=TextEditingController();
  final txtNote=TextEditingController();

  Widget buildDialog(BuildContext context, ListItem item, bool isNew,int listID){
    DbHelper helper=DbHelper();
    if(!isNew){
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }
    else{
      txtQuantity.text = "";
      txtNote.text = "";
    }

    return AlertDialog(
      title: Text((isNew) ? "New Item":"Edit Item"),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtQuantity,
              decoration: InputDecoration(
                  hintText: "How many of the product"
              ),
            ),
            TextField(
              controller: txtNote,
              decoration: InputDecoration(
                  hintText: "Aditional Note"
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  //list.name=txtName.text;
                  //list.priority=int.parse(txtPriority.text);
                  //helper.insertList(list);
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