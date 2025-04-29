import 'package:flutter/material.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class FillNumberField extends StatelessWidget {
  const FillNumberField({super.key, required this.hint, this.ctrl});
final String hint ;
final TextEditingController? ctrl ; 


  @override
  Widget build(BuildContext context) {
    return Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: IntlPhoneField(controller: ctrl,
                cursorColor: Colorize.Theme,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colorize.Theme),
                  labelText: hint,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color:Colorize.SecondColor),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colorize.Theme),
                  ),
                ),
                initialCountryCode: 'EG',
                onChanged: (phone) {
                },
              ),
            );
  }
}