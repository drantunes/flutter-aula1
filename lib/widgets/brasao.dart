import 'package:flutter/material.dart';

class Brasao extends StatelessWidget {
  final String image;
  final double width;

  const Brasao({Key key, this.image, this.width}) : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: image,
        child: Image.network(
          image,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
