import 'package:flutter/material.dart';

class Item_Image extends StatelessWidget {
  final String ImageUrl;

  const Item_Image({
    Key? key,
    required this.ImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image.network(
      ImageUrl, width: double.infinity,
      height: size.height *
          0.25, //para q ocupe solo el 25 porcieto de toda la anchura de la imagen
      fit: BoxFit.scaleDown,
    );
  }
}
