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
class HttpHelper{
  final String urlBase = 'https://simple-grocery-store-api.online/products';

  Future<List?> getProductByCategory(String category) async{
    final String urlFinal = '$urlBase?category=$category';
    //http.Response result = await http.get(Uri.parse(urlFinal));

  }
}