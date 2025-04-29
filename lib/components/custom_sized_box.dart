import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({super.key, required this.length});
final double length ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height * length);
  }
}