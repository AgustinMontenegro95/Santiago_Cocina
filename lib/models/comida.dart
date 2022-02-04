class Comida {
  String? nombreComida;
  String? dificultad;
  String? descripcion;
  String? pasos;
  String? imagen;
  String? ingredientes;
  String? video;
  List<String>? coincidencias;

  Comida({
    this.nombreComida,
    this.dificultad,
    this.descripcion,
    this.pasos,
    this.imagen,
    this.ingredientes,
    this.video,
    this.coincidencias,
  });

  Comida.fromJsonMap(Map<String, dynamic> json) {
    nombreComida = json['NombreComida'];
    dificultad = json['Dificultad'];
    descripcion = json['Descripcion'];
    pasos = json['Pasos'];
    imagen = json['Imagen'];
  }

  Comida.fromMap(document) {
    nombreComida = document['NombreComida'];
    dificultad = document['Dificultad'];
    descripcion = document['Descripcion'];
    pasos = document['Pasos'];
    imagen = document['Imagen'];
    ingredientes = document['Ingredientes'];
    video = document['Video'];
    //coincidencias = document['Coincidencias'];
  }
}
