import 'package:flutter/material.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/components/check_account_row.dart';
import 'package:graduation_project/components/curved_box.dart';
import 'package:graduation_project/components/text_form_field.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:graduation_project/views/Auth/login_view.dart';
import 'package:graduation_project/views/hub_view.dart';
import 'package:graduation_project/Services/signup_controller.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignup() async {
    bool isSuccess = await SignupController.registerUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (isSuccess) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HubView()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colorize.Theme,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .145),
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colorize.Theme),
                child: const Text(
                  "\"Sign up now for a free and lifetime account and unlock your path to career success!\"",
                  maxLines: 4,
                  style: TextStyle(
                      fontSize: 28,
                      color: Colorize.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CurvedBox(
                    height: .7,
                    topLeft: true,
                    topRight: true,
                    color: Colorize.white,
                    children: [
                      const Spacer(flex: 2),
                      Text("Create Account",
                          style: Styles.HeaderLargeText(Colorize.SecondColor)),
                      const Spacer(flex: 3),
                      FillTextField(ctrl: _nameController, hint: "Full Name"),
                      FillTextField(ctrl: _emailController, hint: "Email"),
                      FillTextField(
                        ctrl: _passwordController,
                        hint: "Password",
                          isPassword: true,
                      ), // edit make as this *******

                      const SizedBox(height: 20),
                      Button(
                        width: 250,
                        text: "Create Account",
                        onpressed: _handleSignup,
                      ),
                      const SizedBox(height: 7),
                      const HaveAnAccount(
                          text: "Already have an account?",
                          buttontext: "Login",
                          navigate: Login()),
                      const Spacer(flex: 6)
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
