// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

AppBar appbartarjetaReceta(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xFFFF8F00),
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
          onPressed: () {},
          icon: Icon(
            Icons.bookmark_add_outlined,
            color: Colors.white,
          )),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.share,
            color: Colors.white,
          )),
    ],
  );
}
