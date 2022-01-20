import 'package:dio/dio.dart';

class SistemaService {
  final String _apiURL = "http://127.0.0.1:3000";

  Future<Response> login(correo, contra) async{
    Dio _dio = Dio();
    return await _dio.post(
      "$_apiURL/signin", 
      data:{
        "correo":correo,
        "contra":contra
      }
    );
  }

  Future<Response> register(nombre, celular, universidad, carrera, correo, contra) async{
    Dio _dio = Dio();
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

  Future<Response> logout() async{
    Dio _dio = Dio();
    return await _dio.get(
      "$_apiURL/logout"
    );
  }
}
