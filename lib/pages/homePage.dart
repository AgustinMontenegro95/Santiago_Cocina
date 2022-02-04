// ignore_for_file: prefer_const_constructors, unused_import, sized_box_for_whitespace, camel_case_types, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:santiagococinaapp/models/comida.dart';
import 'package:santiagococinaapp/pages/esqueleto.dart';
import 'package:share/share.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

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
          image: AssetImage("assets/imagen.jpg"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Container(
                  height: 170,
                  width: 170,
                  child: Image(
                    image: AssetImage("assets/logo_naranja.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 140,
              ),
              SizedBox(
                height: 40,
                width: 160,
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
                                  tipoComida: "Dulce",
                                )));
                  },
                  child: Text(
                    "RECETAS DULCES",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 160,
                child: OutlinedButton(
                  child: Text(
                    "RECETAS SALADAS",
                    style: TextStyle(color: Color(0xFFFF8F00)),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Color(0xFFFF8F00)))),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EsqueletoPage(
                                  tipoComida: "Salado",
                                )));
                  },
                ),
              ),
              SizedBox(
                height: 130,
              ),
              Leyenda()
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDialButton(),
    );
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
      /* labelsStyle: /* Your label TextStyle goes here */,
    controller: /* Your custom animation controller goes here */, */
      speedDialChildren: <SpeedDialChild>[
        SpeedDialChild(
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
                        //content: Text("Ingrese la receta a buscar"),
                        actions: <Widget>[
                          TextField(
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
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                                width: 110,
                                child: ElevatedButton(
                                  child: Text(
                                    "CANCELAR",
                                    style: TextStyle(color: Colors.white),
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
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 30,
                                width: 115,
                                child: ElevatedButton(
                                  child: Text(
                                    "BUSCAR",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    String busq = _busquedaController.text;
                                    if (busq.isNotEmpty) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EsqueletoPage(
                                                    nomComida:
                                                        busq,
                                                    tipoComida: "Busqueda",
                                                  )));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "¡Por favor ingrese el nombre de la comida!");
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
                              ),
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
        ),
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
}

class Leyenda extends StatelessWidget {
  const Leyenda({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.developer_mode_outlined,
          color: Color(0xFFFF8F00),
        ),
        Text(" Impulsado por:"),
        TextButton(
          onPressed: () {},
          child: Text(
            "DEVSGO",
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.w900),
          ),
        )
      ],
    );
  }
}
