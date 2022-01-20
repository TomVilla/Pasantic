class Postulacion {
  int idpostulacion;
  String estado;
  String trabajo;
  String empresa;
  String descripcion;

  Postulacion(this.idpostulacion, this.estado, this.trabajo, this.empresa, this.descripcion);

  factory Postulacion.fromMap(Map<String, dynamic> json) { 
      return Postulacion( 
         json['idpostulacion'],
         json['estado'], 
         json['trabajo'], 
         json['empresa'],
         json['descripcion']
      );
   }

   @override
  String toString() {
    return "$idpostulacion, $estado, $trabajo, $descripcion, $empresa";
  }
}