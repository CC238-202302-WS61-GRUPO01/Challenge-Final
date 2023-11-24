/*
class HttpHelper{
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcomming = '/upcoming?';
  final String urlKey = 'api_key=ae6473400bedc2a7b434d4500512ca1f';

  Future<List?> getUpComing() async{
    final String urlFinal = urlBase + urlUpcomming + urlKey;
    print(urlFinal);
    http.Response result = await http.get(Uri.parse(urlFinal));
    if (result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];

      List movies = moviesMap.map(
          (i)=>Movie.fromJson(i)
      ).toList();
      return movies;
    }
    else{
      print(result.body);
      return null;
    }
  }

}
 */
import 'package:app_s12/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class HttpHelper{
  final String urlBase = 'https://simple-grocery-store-api.online/products';

  Future<List?> getProducts() async{
    http.Response result = await http.get(Uri.parse(urlBase));
    if (result.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(result.body);
      final productsMap = jsonResponse['results'];

      List products = productsMap.map(
              (i)=>Product.fromJson(i)
      ).toList();
      return products;
    }
    else{
      print(result.body);
      return null;
    }
  }
}