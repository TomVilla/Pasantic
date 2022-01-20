class Favorito {
  int idfavorito;
  String trabajo;
  String empresa;
  String descripcion;
  int disponibilidad;

  Favorito(this.idfavorito, this.trabajo, this.empresa, this.descripcion, this.disponibilidad);

  factory Favorito.fromMap(Map<String, dynamic> json) { 
      return Favorito( 
         json['idfavorito'],
         json['trabajo'], 
         json['empresa'],
         json['descripcion'],
         json['disponibilidad']
      );
   }

   @override
  String toString() {
    return "$idfavorito, $trabajo, $descripcion, $empresa, $disponibilidad";
  }
}