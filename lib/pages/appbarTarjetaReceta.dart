// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:santiagococinaapp/models/comida.dart';
import 'package:share/share.dart';

SliverAppBar appbartarjetaReceta(BuildContext context, Comida comida) {
  return SliverAppBar(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
    backgroundColor: Color(0xFFFF8F00).withOpacity(0.60),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    elevation: 0,

    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        )),
    // ignore: prefer_const_literals_to_create_immutables
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Share.share(
              "Receta de ${comida.nombreComida}. \n\n-> Descripcion: ${comida.descripcion} \n\nEncontra más información descargando la aplicación Santiago Cocina en: https://play.google.com/store/apps/details?id=com.linkedin.android&hl=es_AR&gl=US");
        },
        icon: Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
      SizedBox(width: 15,)
    ],
  );
}
