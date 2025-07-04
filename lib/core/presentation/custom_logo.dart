import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo(
      {super.key,
      required this.child,
      this.width = double.infinity,
      this.height = 80});

  final Widget child;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}
