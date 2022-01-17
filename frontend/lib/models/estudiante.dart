class Estudiante {
  String nombre;
  String telefono;
  String universidad;
  String carrera;
  String email;
  String contra;

  Estudiante(this.nombre, this.telefono, this.universidad, this.carrera, this.email, this.contra);

  factory Estudiante.fromMap(Map<String, dynamic> json) { 
      return Estudiante( 
         json['nombre'], 
         json['telefono'], 
         json['universidad'], 
         json['carrera'], 
         json['email'], 
         json['contra'] 
      );
   }

   @override
  String toString() {
    return "$nombre, $telefono, $universidad, $carrera, $email, $contra";
  }
}