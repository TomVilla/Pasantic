class Postulacion {
  int idpasantia;
  String estado;
  String trabajo;
  String empresa;
  String descripcion;

  Postulacion(this.idpasantia, this.estado, this.trabajo, this.empresa, this.descripcion);

  factory Postulacion.fromMap(Map<String, dynamic> json) { 
      return Postulacion( 
         json['idpasantia'],
         json['estado'], 
         json['trabajo'], 
         json['empresa'],
         json['descripcion']
      );
   }

   @override
  String toString() {
    return "$idpasantia, $estado, $trabajo, $descripcion, $empresa";
  }
}