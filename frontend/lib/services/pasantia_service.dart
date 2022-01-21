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
          Pasantia.fromMap(item)
        );
      }
      return listaPasantias;
    } else {
      throw Exception("Fallo la peticion de Pasantias");
    }
  }

  Future<Pasantia> getPasantiasById(int id) async {
    Response res = await get(Uri.parse('$_apiURL/findone/$id'));

    if(res.statusCode == 200) {
      String body = utf8.decode(res.bodyBytes);
      var json = jsonDecode(body)['rows'][0];

      return Pasantia.fromMap(json);
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
          Pasantia.fromMap(item)
        );
      }
      return listaPasantias;
    } else {
      throw Exception("Fallo la busqueda de Pasantias");
    }
  }
}