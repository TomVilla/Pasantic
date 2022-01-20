import 'dart:convert';
import 'package:http/http.dart';
import 'package:frontend/models/favorito.dart';

class FavoritoService {
  final String _apiURL = "http://127.0.0.1:3000/practices/fav";

  Future<List<Favorito>> getFavoritos() async {
    List<Favorito> favorito = [];
    Response res = await get(Uri.parse(_apiURL));

    if (res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      var json = jsonDecode(body)["rows"];

      for(var item in json){
        favorito.add(
          Favorito( 
            item['idfavorito'],
            item['trabajo'], 
            item['empresa'],
            item['descripcion'],
            item['disponibilidad']
          )
        );
      }
      return favorito;
    } else {
      throw Exception("Fallo la peticion de Favoritos");
    }
  }

  Future<int> eliminarFavorito(int id) async {
    Response res = await delete(Uri.parse("$_apiURL/$id"));

    if(res.statusCode == 200) {
      return res.statusCode;
    } else {
      return 0;
    }
  }
}