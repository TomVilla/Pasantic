
import 'package:dio/dio.dart';
class EstudianteService {
  final Uri _apiURL = Uri.parse("http://127.0.0.1:3000/signup");
  Dio dio = Dio();
  newEstudiante(nombre,celular,universidad,carrera,correo,contra) async{
    return await dio.post("http://127.0.0.1:3000/signup",
      data:{"nombre":nombre, "celular":celular, "universidad":carrera, "carrera":carrera,"correo":correo,"contra":contra});
    }
}