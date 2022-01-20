import 'package:dio/dio.dart' as packagedio;


class SistemaService {
  final String _apiURL = "http://127.0.0.1:3000";
    Future<packagedio.Response> logOutEstudiante() async{
    packagedio.Dio _dio = packagedio.Dio();
    return await _dio.get(
      "$_apiURL/logout"
    );
  }
}
