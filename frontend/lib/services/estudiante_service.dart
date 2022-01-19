import 'dart:convert';

import 'package:http/http.dart';
import 'package:dio/dio.dart' as packagedio;
import 'package:frontend/models/estudiante.dart';

class EstudianteService {
  final String _apiURL = "http://127.0.0.1:3000";

  Future<packagedio.Response> newEstudiante(nombre, celular, universidad, carrera, correo, contra) async{
    packagedio.Dio _dio = packagedio.Dio();
    return await _dio.post(
      "$_apiURL/signup", 
      data:{
        "nombre":nombre, 
        "celular":celular, 
        "universidad":universidad, 
        "carrera":carrera,
        "correo":correo,
        "contra":contra
      }
    );
  }
  Future<packagedio.Response> loginEstudiante(correo, contra) async{
    packagedio.Dio _dio = packagedio.Dio();
    return await _dio.post(
      "$_apiURL/signin", 
      data:{
        "correo":correo,
        "contra":contra
      }
    );
  }
  Future<Estudiante> infoEstudiante() async {
    Response res = await get(Uri.parse("$_apiURL/profile"));

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