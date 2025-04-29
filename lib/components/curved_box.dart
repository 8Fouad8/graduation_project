import 'package:flutter/material.dart';
import 'package:graduation_project/models/styles.dart';

class CurvedBox extends StatelessWidget {
  const CurvedBox({super.key, required this.children, required this.height,  this.color= Colorize.Theme, this.topLeft, this.topRight, this.bottomLeft, this.bottomright});
final List<Widget> children ;
final double height ; 
final Color color ;
final bool? topLeft; 
final bool? topRight ; 
final bool? bottomLeft; 
final bool? bottomright; 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * height,
            decoration: BoxDecoration(
              color: color, // Transparent background
              borderRadius: BorderRadius.only(
                topLeft: topLeft == true ? Radius.elliptical(50, 50) : Radius.zero,
                topRight: topRight == true ? Radius.elliptical(50, 50) : Radius.zero,
                bottomLeft: bottomLeft == true ? Radius.elliptical(50, 50) : Radius.zero,
                bottomRight: bottomright == true ? Radius.elliptical(50, 50) : Radius.zero,
              ),
            ),
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children)),
    
      ],
    );
  }
}
