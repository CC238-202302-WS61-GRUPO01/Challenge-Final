import 'package:flutter/cupertino.dart';

import '../utils/httpHelper.dart';

class ProductDropdown extends StatefulWidget {
  const ProductDropdown({super.key});

  @override
  State<ProductDropdown> createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  late List products;
  late int productsCount;

  late HttpHelper helper;

  Future initialize() async{
    products = (await helper.getProducts())!;
    setState(() {
      productsCount = products.length;
      products = products;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
  @override
  void initState(){
    helper = HttpHelper();
    initialize();
    super.initState();
  }
}
