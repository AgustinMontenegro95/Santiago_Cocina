

class Comida {
  String? nombreComida;
  String? dificultad;
  String? descripcion;
  String? pasos;
  String? imagen;

  Comida({this.nombreComida, this.dificultad, this.descripcion, this.pasos, this.imagen});

  factory Comida.fromMap(map){
    return Comida(
      nombreComida: map['NombreComida'],
      dificultad: map['Dificultad'],
      descripcion: map['Descripcion'],
      pasos: map['Pasos'],
      imagen: map['Imagen'],
    );
  }

  
}