// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:santiagococinaapp/pages/ItemImange.dart';
import 'package:santiagococinaapp/pages/appbarTarjetaReceta.dart';

class tarjetaReceta extends StatelessWidget {
  tarjetaReceta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF8F00),
      appBar: appbartarjetaReceta(context),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        Item_Image(
          ImageUrl:
              "https://www.sitiosargentina.com.ar/wp-content/uploads/2015/05/tortilla-santiagena-660x330.jpg",
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Item_info(),
        )
      ],
    );
  }
}

class Item_info extends StatelessWidget {
  const Item_info({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          encabezado(),
          SizedBox(
            height: 25,
          ),
          Text("hoasfladmgvkdsnbkndsbkdsn"),
          Text("hoasfladmgvkdsnbkndsbkdsn")
        ],
      ),
    );
  }
}

class encabezado extends StatelessWidget {
  const encabezado({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "Nombre Comida",
              style: TextStyle(
                fontFamily: "Times New Roman",
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("otro texto"),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blueAccent,
        ),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.symmetric(vertical: 15),
        height: 66,
        width: 65,
        child: Text(
          "F",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    ]);
  }
}
