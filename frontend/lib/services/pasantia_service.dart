import 'dart:convert';
import 'package:http/http.dart';
import 'package:frontend/models/pasantia.dart';

class PasantiaService {
  final String _apiURL = "http://127.0.0.1:3000/practices";

  Future<List<Pasantia>> getPasantias() async {
    List<Pasantia> listaPasantias = [];
    Response res = await get(Uri.parse('$_apiURL/all'));

    if(res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      var json = jsonDecode(body);

      for (var item in json['rows']) {
        listaPasantias.add(
          Pasantia(
            item['idpasantia'], 
            item['trabajo'], 
            item['idempresa'], 
            item['disponibilidad'], 
            item['fechapub'], 
            item['descripcion'], 
            item['requisitos'],
            item['empresa'],
            item['direccion'],
            item['telefono'],
            item['email']
          )
        );
      }
      return listaPasantias;
    } else {
      throw Exception("Fallo la peticion de Pasantias");
    }
  }

  Future<List<Pasantia>> getPasantiasbyKeyword(String keyword) async {
    List<Pasantia> listaPasantias = [];
    Response res = await get(Uri.parse('$_apiURL/keyword/$keyword'));
    if(res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      var json = jsonDecode(body);

      for (var item in json['rows']) {
        listaPasantias.add(
          Pasantia(
            item['idpasantia'], 
            item['trabajo'], 
            item['idempresa'], 
            item['disponibilidad'], 
            item['fechapub'], 
            item['descripcion'], 
            item['requisitos'],
            item['empresa'],
            item['direccion'],
            item['telefono'],
            item['email']
          )
        );
      }
      return listaPasantias;
    } else {
      throw Exception("Fallo la busqueda de Pasantias");
    }
  }

  Future<bool> verificarFavorito(int id) async {
    Response res = await get(Uri.parse("$_apiURL/verfav/$id"));
    
    if (res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      var json = jsonDecode(body);
      if(json["rows"].length!=0) {
        return false;
      } else{
        return true;
      }
    } else {
      throw Exception("Fallo la verificacion de Favoritos");
    }
  }

  Future<int> addPasantiaToFavoritos(int id) async {
    Response res = await post(Uri.parse("$_apiURL/addfav/$id"));

    if (res.statusCode == 200) {
      return res.statusCode;
    } else {
      throw Exception("Fallo la insercion en Favoritos");
    }
  }

  Future<bool> verificarPostulacion(int id) async {
    Response res = await get(Uri.parse("$_apiURL/verpost/$id"));
    
    if (res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      var json = jsonDecode(body);
      if(json["rows"].length!=0) {
        return false;
      } else{
        return true;
      }
    } else {
      throw Exception("Fallo la verificacion de Postulacion");
    }
  }

  Future<int> postularAPasantia(int id) async {
    Response res = await post(Uri.parse("$_apiURL/post/$id"));
    
    if (res.statusCode == 200) {
      return res.statusCode;
    } else {
      throw Exception("Fallo la insercion en Favoritos");
    }
  }
}