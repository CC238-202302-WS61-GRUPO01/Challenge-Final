import 'package:flutter/material.dart';
import 'package:app_s12/utils/dbhelper.dart';
import 'package:app_s12/models/shopping_list.dart';
import 'package:app_s12/models/list_item.dart';
import 'package:app_s12/ui/shopping_list_dialog.dart';
import 'package:app_s12/ui/items_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //DbHelper helper = DbHelper();
    //helper.testDB();

    return MaterialApp(
        home: ShowList(),
    );
  }
}

class ShowList extends StatefulWidget {
  const ShowList({super.key});

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingList=[];

  ShoppingListDialog? dialog;
  @override
  void initState(){
    dialog=ShoppingListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
      ),
        body: ListView.builder(
            itemCount: (shoppingList!=null)? shoppingList.length:0,
            itemBuilder: (BuildContext context, int index){
              return Dismissible(
                  key: Key(shoppingList[index].name),
                  onDismissed: (direction){
                    helper!.deleteList(shoppingList[index]);
                    setState(() {
                      shoppingList.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(shoppingList[index].name),
                    leading: CircleAvatar(
                      child: Text(shoppingList[index].priority.toString()),
                      ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog!.buildDialog(context, shoppingList[index], false));
                      },
                    ),
                    onTap: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>
                          ItemScreen(shoppingList[index]),
                  ),);
                },
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
      ),
    );
  }

  Future showData() async{
    await helper.openDb();
    shoppingList = await helper.getLists();

    setState(() {
      shoppingList=shoppingList;
    });
  }
}

