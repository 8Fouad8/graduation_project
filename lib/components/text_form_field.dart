import 'package:flutter/material.dart';
import 'package:graduation_project/models/styles.dart';

class FillTextField extends StatelessWidget {
  const FillTextField({super.key, required this.ctrl, required this.hint, this.isPassword});
final String hint;
final TextEditingController? ctrl ;
final bool? isPassword ;  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: ctrl,
         //         obscureText: isPassword,

                    cursorColor: Colorize.Theme,
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colorize.SecondColor)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colorize.Theme))),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
       const SizedBox(height: 20),],
    );
  }
}

