import 'package:flutter/material.dart';

class MovieLogo extends StatelessWidget {
  const MovieLogo({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/pngs/logo.png',
      height: height,
    );
  }
}
