import 'dart:convert';
import 'package:http/http.dart';
import 'package:frontend/models/postulacion.dart';

class PostulacionService {
  final String _apiURL = "http://127.0.0.1:3000/practices/post";

  Future<List<Postulacion>> getPostulaciones() async {
    List<Postulacion> postulacion = [];
    Response res = await get(Uri.parse("$_apiURL/all"));

    if (res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      var json = jsonDecode(body)["rows"];

      for(var item in json){
        postulacion.add(
          Postulacion.fromMap(item)
        );
      }
      return postulacion;
    } else {
      throw Exception("Fallo la peticion de Postulaciones");
    }
  }

  Future<bool> verificarPostulacion(int id) async {
    Response res = await get(Uri.parse("$_apiURL/ver/$id"));
    
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

  Future<int> postular(int id) async {
    Response res = await post(Uri.parse("$_apiURL/add/$id"));
    
    if (res.statusCode == 200) {
      return res.statusCode;
    } else {
      throw Exception("Fallo la insercion en Favoritos");
    }
  }

  Future<int> eliminarPostulacion(int id) async {
    Response res = await delete(Uri.parse("$_apiURL/delete/$id"));

    if(res.statusCode == 200) {
      return res.statusCode;
    } else {
      return 0;
    }
  }
}