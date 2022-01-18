class Estudiante {
  String nombre;
  String celular;
  String universidad;
  String carrera;
  String correo;

  Estudiante(this.nombre, this.celular, this.universidad, this.carrera, this.correo);

  factory Estudiante.fromMap(Map<String, dynamic> json) { 
      return Estudiante( 
        json['nombre'], 
        json['celular'], 
        json['universidad'], 
        json['carrera'], 
        json['correo']
      );
   }

   @override
  String toString() {
    return "$nombre, $celular, $universidad, $carrera, $correo";
  }
}