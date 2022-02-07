// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:santiagococinaapp/models/comida.dart';
import 'package:santiagococinaapp/pages/appbarTarjetaReceta.dart';
import 'package:santiagococinaapp/pages/constants.dart';
import 'package:santiagococinaapp/pages/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatelessWidget {
  final Comida comida;

  Detail(this.comida);

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          appbartarjetaReceta(context, comida),
        ],
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTextTitleVariation1(comida.nombreComida.toString()),
                    buildTextSubTitleVariation1(comida.descripcion),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 310,
                padding: EdgeInsets.only(left: 15),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTextTitleVariation2('Dificultad', false),
                        SizedBox(
                          height: 15,
                        ),
                        buildNutrition(comida.dificultad.toString()),
                      ],
                    ),
                    Positioned(
                      right: -90,
                      child: Hero(
                        tag: comida.imagen.toString(),
                        child: Container(
                          height: 310,
                          width: 310,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: NetworkImage(comida.imagen.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    buildTextTitleVariation2('Ingredientes', false),
                    SizedBox(height: 15,),
                    buildTextSubTitleVariation1(pasos(comida.ingredientes)),
                    SizedBox(
                      height: 35,
                    ),
                    buildTextTitleVariation2('Pasos a seguir', false),
                    SizedBox(height: 15,),
                    buildTextSubTitleVariation1(pasos(comida.pasos)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _launchURL,
          backgroundColor: kPrimaryColor,
          icon: Icon(
            Icons.play_circle_fill,
            color: Colors.white,
            size: 32,
          ),
          label: Text(
            "Ver video",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget buildNutrition(String value) {
    return Container(
      height: 60,
      width: 150,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [kBoxShadow],
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  pasos(String? pasos) {
    String texto = pasos.toString().replaceAll("*", "\n\n");
    return texto;
  }

  void _launchURL() async {
    String? _url = comida.video;
    if (!await launch("$_url")) throw 'Could not launch "$_url"';
  }
}
