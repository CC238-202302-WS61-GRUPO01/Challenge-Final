import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_s12/models/shopping_list.dart';
import 'package:app_s12/models/list_item.dart';

class DbHelper{
  final int version = 4;
  Database? db;

  static final DbHelper dbHelper=DbHelper.internal();
  DbHelper.internal();
  factory DbHelper(){
    return dbHelper;
  }

  Future<Database> openDb() async{
    if(db==null){
      db=await openDatabase(join(await getDatabasesPath(), 'shopping.db'),
      onCreate: (database, version){
        database.execute('CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, category TEXT)');
        database.execute('CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
        database.execute('CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, idProduct INTEGER, quantity INTEGER, note TEXT, FOREIGN KEY(idProduct) REFERENCES products(id)), FOREIGN KEY(idList) REFERENCES lists(id))');
      }, version: version);
    }
    return db!;
  }

  Future testDB() async{
    db = await openDb();

    await db!.execute('INSERT INTO lists VALUES(0, "Monitores", 1)');
    await db!.execute('INSERT INTO lists VALUES(1, "Impresoras", 3)');
    await db!.execute('INSERT INTO lists VALUES(2, "Teclados", 3)');
    await db!.execute('INSERT INTO items VALUES(0, 0, 0, "Monitor LG", "6 Unds", "21 in")');
    await db!.execute('INSERT INTO items VALUES(1, 1, 0, "Impresora HP", "10 Unds", "Tinta no incluida")');
    
    List list = await db!.rawQuery('SELECT * FROM lists');
    List item = await db!.rawQuery('SELECT * FROM items');

    /*print(list[0]);
    print(item[0]);
    print(list[1]);
    print(item[1]);*/
  }

  Future<int> insertList(ShoppingList list) async{
    int id=await this.db!.insert('lists', list.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> insertItem(ListItem item) async{
    int id=await this.db!.insert('items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<ShoppingList>> getLists() async{
    final List<Map<String,dynamic>> maps=await db!.query('lists');
    return List.generate(maps.length, (i){
      return ShoppingList(
          maps[i]['id'],
          maps[i]['name'],
          maps[i]['priority'],
      );
    });
  }

  Future<List<ListItem>> getItems(int idList) async{
    final List<Map<String,dynamic>> maps=await db!.query('items', where: 'idList=?', whereArgs: [idList]);
    return List.generate(maps.length, (i){
      return ListItem(
        maps[i]['id'],
        maps[i]['idList'],
        maps[i]['idProduct'],
        maps[i]['quantity'],
        maps[i]['note'],
      );
    });
  }

  Future<int> deleteList(ShoppingList list) async{
    int result = await db!.delete('items', where: 'idList = ?', whereArgs: [list.id]);

    result = await db!.delete('lists', where: 'id = ?', whereArgs: [list.id]);

    return result;
  }
}