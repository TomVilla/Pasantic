import 'dart:convert';

import 'package:http/http.dart';
import 'package:frontend/models/estudiante.dart';

class EstudianteService {
  final String _apiURL = "http://127.0.0.1:3000/profile";
  Future<Estudiante> infoEstudiante() async {
    Response res = await get(Uri.parse(_apiURL));

    if(res.statusCode == 200) {
      var json = jsonDecode(res.body)["rows"][0];

      return Estudiante(
        json['nombre'], 
        json['celular'], 
        json['universidad'], 
        json['carrera'], 
        json['correo'],
      );
    } else {
      throw Exception("Fallo la peticion de Pasantias");
    }
  }
}