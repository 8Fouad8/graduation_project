// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';


class Colorize {
  static const Color white =  Color.fromARGB(255, 255, 255, 255);
  static const Color Theme =  Color(0xFF003A3A);
  static const Color SecondColor =  Color(0xFF006666);
  static const Color ThirdColor =  Color(0xFFFCD980);
  static Color TextColor = const Color.fromARGB(255, 255, 255, 255);

  static ColorIt(b, c, d) {
    return Color.fromARGB(255, b, c, d);
  }
}

class Styles {
  static ButtonStyle DButton() {
    return ElevatedButton.styleFrom(
        backgroundColor: Colorize.Theme,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        fixedSize: const Size(170, 54));
  }

  static ButtonStyle DrawerButton() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colorize.SecondColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(9))),
    );
  }
  static TextStyle HeaderText([double? fontsize, Color? color]) {
    return TextStyle(
        fontWeight: FontWeight.w500, 
        fontSize: fontsize ?? 28, 
        color: color ?? Colorize.white,
    );
  }
    static TextStyle HeaderTextTheme() {
    return const TextStyle(
        fontWeight: FontWeight.w500, fontSize: 28, color: Colorize.Theme,);
  }

  static TextStyle TitleText() {
    return const TextStyle(
      fontSize: 23,
      color: Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      shadows: [
        Shadow(
          color: Color.fromARGB(255, 70, 70, 70), // Shadow color
          offset: Offset(2, 2), // Shadow offset
          blurRadius: 7, // Shadow blur radius
        ),
        // You can add more Shadow objects here for additional shadows
      ],
    );
  }

   static TextStyle TitleTextTheme() {
    return const TextStyle(
      fontSize: 21,
      color: Colorize.SecondColor,
      fontWeight: FontWeight.bold,
      
    );
  }
static TextStyle HeaderLargeText(Color color) {
  return TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 30,
    color: color,
  );
}
}
