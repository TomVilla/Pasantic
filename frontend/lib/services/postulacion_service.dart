import 'dart:convert';
import 'package:http/http.dart';
import 'package:frontend/models/postulacion.dart';

class PostulacionService {
  final String _apiURL = "http://127.0.0.1:3000/practices/mypostulations";

  Future<List<Postulacion>> getPostulaciones() async {
    List<Postulacion> postulacion = [];
    Response res = await get(Uri.parse(_apiURL));

    if (res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      var json = jsonDecode(body)["rows"];

      for(var item in json){
        postulacion.add(
          Postulacion( 
            item['idpostulacion'],
            item['estado'], 
            item['trabajo'], 
            item['empresa'],
            item['descripcion']
          )
        );
      }
      return postulacion;
    } else {
      throw Exception("Fallo la peticion de Postulaciones");
    }
  }

  Future<int> eliminarPostulacion(int id) async {
    Response res = await delete(Uri.parse("$_apiURL/$id"));

    if(res.statusCode == 200) {
      return res.statusCode;
    } else {
      return 0;
    }
  }
}