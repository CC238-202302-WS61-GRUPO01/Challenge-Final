import 'package:app_s12/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/httpHelper.dart';

class ProductDropdown extends StatefulWidget {
  const ProductDropdown({super.key});

  @override
  State<ProductDropdown> createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  List? products;
  //late int productsCount;
  int productId = 0;

  late HttpHelper helper;

  Future initialize() async{
    helper = HttpHelper();
    products = helper.getProducts() as List;
  }
  @override
  void initState(){
    initialize();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> dropdownList = [];
    if(products != null){
      for (var prod in products!){
        var futureBuilder = FutureBuilder<Product>(
          future: prod,
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return DropdownMenuItem(
                  value: snapshot.data!.id,
                  child: Text('${snapshot.data!.name}',)
              );
            }
            else if (snapshot.hasError) {
              return const DropdownMenuItem(
                  value: 0,
                  child: Text('Could not load data',)
              );
            }
            return const DropdownMenuItem(
                value: 0,
                child: Text('Loading...',)
            );
          },
        );
        dropdownList.add(futureBuilder.builder as DropdownMenuItem);
      }
    }
    return DropdownButton(
      onChanged: (var newValue){
        setState(() {
          productId = newValue!;
        });
      },
      items: dropdownList,
    );
  }
}
