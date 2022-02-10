// ignore_for_file: prefer_const_constructors, unused_import, sized_box_for_whitespace, camel_case_types, unnecessary_new, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:santiagococinaapp/models/comida.dart';
import 'package:santiagococinaapp/pages/esqueleto.dart';
import 'package:share/share.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _busquedaController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    _busquedaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white70,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          colorFilter: ColorFilter.srgbToLinearGamma(),
          //opacity: 0.35,
          image: AssetImage("assets/fondo.jfif"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _imagenLogo(context),
              _botonComida(context, "Dulce", "RECETAS DULCES"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              _botonComida(context, "Salado", "RECETAS SALADAS"),
              Expanded(child: Container()),
              _leyenda(),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDialButton(),
    );
  }

  SizedBox _botonComida(BuildContext context, String tipoComida, String recetas) {
    return SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFFF8F00)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EsqueletoPage(
                                tipoComida: tipoComida,
                              )));
                },
                child: FittedBox(
                  child: Text(
                    recetas,
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            );
  }

  SizedBox _imagenLogo(BuildContext context) {
    return SizedBox(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width * 0.55,
                child: Image(
                  image: AssetImage("assets/logo_naranja.png"),
                ),
              ),
            );
  }

  Widget _leyenda(){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.developer_mode_outlined,
            color: Color(0xFFFF8F00),
          ),
          Text(" Impulsado por:"),
          TextButton(
            onPressed: () {
              _sendMail();
            },
            child: Text(
              "SOLUDEV",
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    );
  }
  
  _sendMail() async {
    // Android and iOS
    const uri =
        'mailto:soludevarg@gmail.com?'
        'subject=Contacto'
        '&'
        'body=Insertar consulta aqui.';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  SpeedDial SpeedDialButton() {
    return SpeedDial(
      labelsStyle: TextStyle(
        color: Colors.black87,
        fontSize: 13,
      ),
      child: Icon(
        Icons.add,
        size: 40,
        color: Color(0xFFFF8F00),
      ),
      closedForegroundColor: Colors.black,
      openForegroundColor: Colors.grey,
      closedBackgroundColor: Colors.white,
      openBackgroundColor: Colors.black,
      speedDialChildren: <SpeedDialChild>[
        _buscarReceta(),
        SpeedDialChild(
          child: Icon(Icons.share),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'COMPARTIR APP',
          onPressed: () {
            Share.share(
                "Te invitamos a descargar la aplicación Santiago Cocina haciendo click en el siguiente enlace: https://play.google.com/store/apps/details?id=com.linkedin.android&hl=es_AR&gl=US");
          },
          closeSpeedDialOnPressed: true,
        )
        //  Your other SpeeDialChildren go here.
      ],
    );
  }

  SpeedDialChild _buscarReceta() {
    return SpeedDialChild(
        child: Icon(Icons.manage_search_rounded),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[200],
        label: 'BUSCAR RECETA',
        onPressed: () {
          showDialog(
              barrierColor: Colors.blue.withOpacity(0.2),
              barrierDismissible: false,
              context: context,
              builder: (buildcontext) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0))),
                      elevation: 25,
                      title: Text(
                        "BUSCAR RECETA",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      actions: <Widget>[
                        _textFieldBuscarReceta(),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _botonCancelar(context),
                            SizedBox(
                              width: 20,
                            ),
                            _botonBuscar(context),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        )
                      ],
                    );
                  },
                );
              });
        },
        closeSpeedDialOnPressed: true,
      );
  }

  TextField _textFieldBuscarReceta() {
    return TextField(
                        autofocus: false,
                        autocorrect: true,
                        controller: _busquedaController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.food_bank_outlined,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: 'Ingrese la comida...',
                          helperText: "Ej. Empanadas.",
                          suffixIcon: IconButton(
                            onPressed: _busquedaController.clear,
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      );
  }

  SizedBox _botonBuscar(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 110,
      child: ElevatedButton(
        child: FittedBox(
          child: Text(
            "BUSCAR",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onPressed: () {
          String busq = _busquedaController.text;
          if (busq.isNotEmpty) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EsqueletoPage(
                          nomComida: busq,
                          tipoComida: "Busqueda",
                        )));
          } else {
            Fluttertoast.showToast(
                msg:
                    "¡Por favor, ingrese el nombre de la comida!");
          }
          _busquedaController.clear();
        },
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shape: new RoundedRectangleBorder(
            borderRadius:
                new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.orange),
          ),
          primary: Colors.orange,
        ),
      ),
    );
  }

  SizedBox _botonCancelar(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 110,
      child: ElevatedButton(
        child: FittedBox(
          child: Text(
            "CANCELAR",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          elevation: 10,
          shape: new RoundedRectangleBorder(
            borderRadius:
                new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.orange),
          ),
          primary: Colors.orange,
        ),
      ),
    );
  }

  


}
