import 'package:flutter/material.dart';
import 'package:santiagococinaapp/intro/intro.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  //Funcion para inicializar todos las dependencias que el proyecto necesita.
  WidgetsFlutterBinding.ensureInitialized();
  //Verifica el JSON, utiliza su informacion para inicializar el proyecto de firebase.
  Firebase.initializeApp().then((value) {
    runApp(RecetaApp());
  });

  
}

class RecetaApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Santiago Cocina App',
      home: IntroPage(),
    );
  }
}