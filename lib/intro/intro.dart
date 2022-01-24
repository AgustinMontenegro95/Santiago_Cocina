// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:santiagococinaapp/pages/homePage.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _lottieAnimation;
  var expanded = false;
  double _bigFontSize = kIsWeb ? 234 : 178;
  //transicion letras
  final transitionDuration = Duration(seconds: 1);


  @override
  void initState() {
    _lottieAnimation = AnimationController(
      vsync: this,
      // 
      duration: Duration(seconds: 1),
    );

    //transicion S
    Future.delayed(Duration(seconds: 1))
        .then((value) => setState(() => expanded = true))
        //transicion 
        .then((value) => Duration(seconds: 1))
        .then(
          //transicion gif -> homepage
          (value) => Future.delayed(Duration(seconds: 2)).then(
            (value) => _lottieAnimation.forward().then(
                  (value) => Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false),
                ),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedDefaultTextStyle(
                  duration: transitionDuration,
                  curve: Curves.fastOutSlowIn,
                  style: TextStyle(
                    color: Color(0xFFFF8F00),
                    fontSize: !expanded ? _bigFontSize : 45,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                  child: Text(
                    "S",
                  ),
                ),
                AnimatedCrossFade(
                  firstCurve: Curves.fastOutSlowIn,
                  crossFadeState: !expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: transitionDuration,
                  firstChild: Container(),
                  secondChild: _logoRemainder(),
                  alignment: Alignment.centerLeft,
                  sizeCurve: Curves.easeInOut,
                ),
              ],
            ),

            AnimatedCrossFade(
                  firstCurve: Curves.fastOutSlowIn,
                  crossFadeState: !expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: transitionDuration,
                  firstChild: Container(),
                  secondChild: _logoRemainder2(),
                  alignment: Alignment.centerLeft,
                  sizeCurve: Curves.easeInOut,
                ),

          ],
        ),
      ),
    );
  }

  Widget _logoRemainder() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "ANTIAGO ",
          style: TextStyle(
            color: Color(0xFFFF8F00),
            fontSize: 45,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        LottieBuilder.asset(
          'assets/food.json',
          onLoaded: (composition) {
            _lottieAnimation..duration = composition.duration;
          },
          frameRate: FrameRate.max,
          repeat: false,
          animate: false,
          height: 75,
          width: 75,
          controller: _lottieAnimation,
        ),
      ],
    );
  }

  Widget _logoRemainder2() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "COCINA",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 40,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            
          ),
        ),
      ],
    );
  }

  
}