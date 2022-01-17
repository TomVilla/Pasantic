import 'package:frontend/models/estudiante.dart';
import 'package:http/http.dart';

class EstudianteService {
  final Uri _apiURL = Uri.parse("http://127.0.0.1:3000/signup");

  Future<String> newEstudiante(Estudiante estudiante) async {
    Map data = {
      'nombre': estudiante.nombre,
      'telefono': estudiante.telefono,
      'universidad': estudiante.universidad,
      'carrera': estudiante.carrera,
      'email': estudiante.email,
      'contra': estudiante.contra
    };

    final Response response = await post(
      _apiURL, 
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if(response.statusCode == 200){
      return "Ok";
    } else {
      throw "Error al agregar el estudiante";
    }
  }
}