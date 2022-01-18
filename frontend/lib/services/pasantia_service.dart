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
}