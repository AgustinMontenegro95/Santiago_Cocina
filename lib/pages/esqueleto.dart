
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:santiagococinaapp/models/comida.dart';
import 'package:santiagococinaapp/pages/tarjetaReceta.dart';


class EsqueletoPage extends StatefulWidget {
  final String tipoComida;

  const EsqueletoPage(this.tipoComida, {Key? key}) : super(key: key);

  @override
  State<EsqueletoPage> createState() => _EsqueletoPageState();
}

class _EsqueletoPageState extends State<EsqueletoPage> {
  @override
  Widget build(BuildContext context) {

    
    String imagen1 = "";
    String imagen2 = "";

    void getComida() async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('Salado');

    QuerySnapshot tipoCom = await collectionReference.get();

    

    if (tipoCom.docs.isNotEmpty) {
      for (var doc in tipoCom.docs) {
          Comida comida = Comida.fromMap(doc);
          print(" COMIDAaaaaaaaaaaaaaaaaaaa: ${comida.nombreComida}");
          /* if (comida.nombreComida == "Chipaco") {
            imagen2 = comida.imagen.toString();
          }
          if (comida.nombreComida == "Tortilla Santiagueña") {
            imagen1 = comida.imagen.toString();
          } */
          
      }
    }

  }

    String nombre1 = "Alfajor Santiagueño";

    String imagen3 = "https://s3-us-west-2.amazonaws.com/lasaga-blog/media/images/grupo_imagen.original.jpg";

    @override
    void initState() {
      super.initState();
      getComida();
      
    }

    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Color(0xFFFF8F00),
        title: Text("Dulce/Salado"),
      ),
      
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    child: _tarjeta1(imagen1, nombre1, context),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    child: _tarjeta1(imagen3, nombre1, context),
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    child: _tarjeta1(imagen2, nombre1, context),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    child: _tarjeta1(imagen3, nombre1, context),
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    child: _tarjeta1(imagen1, nombre1, context),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    child: _tarjeta1(imagen1, nombre1, context),
                  ),
                ],
              ),

              Row(
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    child: _tarjeta1(imagen1, nombre1, context),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    child: _tarjeta1(imagen1, nombre1, context),
                  ),
                ],
              ),

              
            ],
          )
        ],
      ), 
      

    );
  }

  Card _tarjeta1(String imagen, String nombre, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: InkWell(

        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => tarjetaReceta() ));
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

              FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(imagen),
                fadeInDuration: Duration(milliseconds: 200),
                fit: BoxFit.cover,
                height: 125,
                //placeholderFit: BoxFit.cover,
                
              ),

              // Usamos Container para el contenedor de la descripción
              Container(
                padding: EdgeInsets.all(13),
                child: Text(nombre, style: TextStyle(color: Color(0xFFFF8F00), fontSize: 16,), textAlign: TextAlign.center,),
                
              ),
            
            ],
          ),
        )
      ),
      // Dentro de esta propiedad usamos ClipRRect
    );
  }
}