import 'package:flutter/material.dart';
import 'package:graduation_project/models/styles.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.onpressed,
    this.color = Colorize.SecondColor,
    required this.text,
    this.navigate,
    this.width,
    this.spacer,
    this.fontSize,
    this.child
  });

  final VoidCallback? onpressed;
  final double? width;
  final String text;
  final Widget? navigate;
  final bool? spacer;
  final Color color;
  final double? fontSize;
  final Widget? child;

  void _handlePress(BuildContext context) {
    if (onpressed != null) {
      onpressed!(); // First execute the onPressed function
    }
    if (navigate != null) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (context.mounted) { // Check if the context is still mounted
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigate!),
          );
        }
      });
    }
  }

  double _determineWidth(BuildContext context) {
    if (width != null) {
      return width!;
    } else if (spacer == true) {
      return MediaQuery.of(context).size.width * 0.8;
    } else {
      return 120.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 10,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.black,
      ),
      onPressed: () => _handlePress(context), // Call the combined function
      child: SizedBox(
        width: _determineWidth(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize ?? 24,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
