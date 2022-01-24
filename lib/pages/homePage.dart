
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:santiagococinaapp/models/comida.dart';
import 'package:santiagococinaapp/pages/esqueleto.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white70,

      body: Container(
        decoration: BoxDecoration(
          
          image: DecorationImage(
            colorFilter: ColorFilter.srgbToLinearGamma(),
            //opacity: 0.35,
            image: AssetImage("assets/imagen.jpg"),
            fit: BoxFit.cover,
          )
        ),
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

              SizedBox(height: 140,),

              SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFF8F00)), 
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
                    ),
                  ),
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => EsqueletoPage()));
                  }, 
                  child: Text("Recetas dulces", style: TextStyle(fontWeight: FontWeight.w900),),
                ),
              ),
              
              SizedBox(height: 20,),

              SizedBox(
                height: 40,
                width: 140,
                child: OutlinedButton(
                  child: Text("Recetas saladas", style: TextStyle(color: Color(0xFFFF8F00)),),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: Color(0xFFFF8F00)))
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EsqueletoPage("Salado")));
                  },
                ),
              ),

              SizedBox(height: 130,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.developer_mode_outlined, color: Color(0xFFFF8F00),),
                  Text(" Impulsado por:"),
                  TextButton(
                    onPressed: () {
                      
                    }, 
                    child: Text("DEVSGO", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w900 ),)
                  ,)
                ],
              )

          ],
      ),
        ),
      ),


      floatingActionButton: boton_speedDial(),
      
    );


  }
}

class boton_speedDial extends StatelessWidget {
  const boton_speedDial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      child: Icon(Icons.search, color: Color(0xFFFF8F00),),
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
          backgroundColor: Colors.green,
          label: 'Buscar recetas!!!',
          onPressed: () {

          },
          closeSpeedDialOnPressed: false,
        ),
        SpeedDialChild(
          child: Icon(Icons.fastfood_outlined),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          label: 'Buscar por ingredientes!!!',
          onPressed: () {

          },
          closeSpeedDialOnPressed: false,
        )
         //  Your other SpeeDialChildren go here.        
      ],

    );
  }
}