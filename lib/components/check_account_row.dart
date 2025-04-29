import 'package:flutter/material.dart';
import 'package:graduation_project/models/styles.dart';

class HaveAnAccount extends StatelessWidget {
  const HaveAnAccount({super.key, required this.text, required this.buttontext, required this.navigate, this.onpress});
final String text;
final String buttontext;
final Widget navigate;
final VoidCallback? onpress;
  @override
  Widget build(BuildContext context) {
    return  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(text,
                    style: const TextStyle(fontSize: 15)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => navigate));
                  },
                  child: Text(buttontext, style: Styles.TitleTextTheme()),
                )
              ],
            );
  }
}