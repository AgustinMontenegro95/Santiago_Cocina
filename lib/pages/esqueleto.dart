// ignore_for_file: sized_box_for_whitespace, curly_braces_in_flow_control_structures, prefer_const_constructors, unused_element, dead_code, unnecessary_new, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:santiagococinaapp/models/comida.dart';
import 'package:santiagococinaapp/pages/detail.dart';

class EsqueletoPage extends StatefulWidget {
  final String? tipoComida;
  final String? nomComida;

  const EsqueletoPage({this.tipoComida, this.nomComida});

  @override
  State<EsqueletoPage> createState() => _EsqueletoPageState();
}

class _EsqueletoPageState extends State<EsqueletoPage> {
  late Comida comida;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    
    late String appbarTitulo;
    String tComidaFun(){
      if (widget.tipoComida.toString() == "Salado") {
        appbarTitulo = "RECETAS SALADAS";
      } else if (widget.tipoComida.toString() == "Dulce") {
        appbarTitulo = "RECETAS DULCES";
      } else{
        appbarTitulo = "BUSQUEDA";
      }
      return appbarTitulo;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        backgroundColor: const Color(0xFFFF8F00).withOpacity(0.80),
        title: Text(tComidaFun(),
          style: TextStyle(),
        ),
      ),
      body: eleccion(widget.tipoComida.toString(), widget.nomComida.toString()),
    );
  }

  eleccion(String tc, String nc) {
    if (tc.isNotEmpty && tc != "Busqueda") {
      return esqueleto(tc);
    } else if (nc.isNotEmpty) {
      return widgetBusqueda(nc);
    }
  }

  FutureBuilder<QuerySnapshot<Object?>> esqueleto(String tipoC) {
    return FutureBuilder<QuerySnapshot>(
      future: db.collection(tipoC).orderBy("NombreComida").get(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          );
        return Container(
          child: GridView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 190 / 190,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                return Container(
                  height: 190,
                  width: 190,
                  child: _tarjeta1(context, comida = Comida.fromMap(document)),
                );
              }),
        );
      },
    );
  }

  Future<QuerySnapshot<Object?>>? busqueda(String cm) async {
    

    QuerySnapshot document = await db
        .collection("Salado")
        .where("Coincidencias", arrayContains: cm).get();

    if (document.size == 0) {
      QuerySnapshot docu = await db
          .collection("Dulce")
          .where("Coincidencias", arrayContains: cm)
          .get();
      return docu;
    } else 
    return document;
  }

  FutureBuilder<QuerySnapshot<Object?>> widgetBusqueda(String cm) {
    return FutureBuilder<QuerySnapshot>(
      future: busqueda(cm),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          );
        if (snapshot.data!.docs.length == 0) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber, color: Colors.red, size: 125,),
                SizedBox(height: 60,),
                Text("No existen resultados para ", 
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.grey), 
                  textAlign: TextAlign.center,
                ),
                Text(cm, 
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.blue, fontStyle: FontStyle.italic), 
                      textAlign: TextAlign.center,
                    ),
                SizedBox(height: 55,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: Text("VOLVER"),
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.orange),
                    ),
                    primary: Colors.orange,
                  ),
                ),
                SizedBox(height: 120,)
              ],
            ),
          );
        }else{
          return Container(
            child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 190 / 190,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return Container(
                    height: 190,
                    width: 190,
                    child: _tarjeta1(context, comida = Comida.fromMap(document)),
                  );
                }),
          );
        }
      },
    );
  }

  Card _tarjeta1(BuildContext context, Comida comida) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Detail(comida)));
          },
          child: ClipRRect(
            // Los bordes del contenido del card se cortan usando BorderRadius
            borderRadius: BorderRadius.circular(30),
            // EL widget hijo que será recortado segun la propiedad anterior
            child: Column(
              children: <Widget>[
                // Usamos el widget Image para mostrar una imagen
                /* Image(
                // Como queremos traer una imagen desde un url usamos NetworkImage
                image: NetworkImage(imagen),
              ), */

                Container(
                  height: MediaQuery.of(context).size.height * 0.165,
                  width: MediaQuery.of(context).size.width,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(comida.imagen.toString()),
                    fadeInDuration: Duration(milliseconds: 200),
                    fit: BoxFit.cover,
                    //placeholderFit: BoxFit.cover,
                  ),
                ),

                // Usamos Container para el contenedor de la descripción
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      comida.nombreComida.toString(),
                      style: TextStyle(
                        color: Color(0xFFFF8F00),
                        fontSize: 16
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          )),
      // Dentro de esta propiedad usamos ClipRRect
    );
  }
}
