class Pasantia {
  int idpasantia;
  String trabajo;
  int idempresa;
  int disponibilidad;
  String fechapub;
  String descripcion;
  String requisitos;
  String empresa;
  String direccion;
  String telefono;
  String email;

  Pasantia(this.idpasantia, this.trabajo, this.idempresa, this.disponibilidad, this.fechapub, this.descripcion, this.requisitos, this.empresa, this.direccion, this.telefono, this.email);

  factory Pasantia.fromMap(Map<String, dynamic> json) { 
      return Pasantia( 
         json['idpasantia'], 
         json['trabajo'], 
         json['idempresa'], 
         json['disponibilidad'], 
         json['fechapub'], 
         json['descripcion'], 
         json['requisitos'],
         json['empresa'],
         json['direccion'],
         json['telefono'],
         json['email']
      );
   }

   @override
  String toString() {
    return "$idpasantia, $trabajo, $idempresa, $disponibilidad, $fechapub, $descripcion, $requisitos, $empresa, $direccion, $telefono, $email";
  }
}