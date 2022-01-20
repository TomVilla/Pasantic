class Favorito {
  int idpasantia;
  String trabajo;
  String empresa;
  String descripcion;
  int disponibilidad;

  Favorito(this.idpasantia, this.trabajo, this.empresa, this.descripcion, this.disponibilidad);

  factory Favorito.fromMap(Map<String, dynamic> json) { 
      return Favorito( 
         json['idpasantia'],
         json['trabajo'], 
         json['empresa'],
         json['descripcion'],
         json['disponibilidad']
      );
   }

   @override
  String toString() {
    return "$idpasantia, $trabajo, $descripcion, $empresa, $disponibilidad";
  }
}