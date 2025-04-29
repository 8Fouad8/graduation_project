import 'package:flutter/material.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/components/check_account_row.dart';
import 'package:graduation_project/components/curved_box.dart';
import 'package:graduation_project/components/text_form_field.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:graduation_project/views/Auth/signup_view.dart';
import 'package:graduation_project/views/hub_view.dart';
import 'package:graduation_project/Services/login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    bool isSuccess = await LoginController.loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    if (isSuccess) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HubView()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login failed. Please check your credentials.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Colorize.Theme,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * .4,
              child: const Text(
                "Welcome back!",
                style: TextStyle(
                    fontSize: 34,
                    color: Colorize.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CurvedBox(
                  height: .6,
                  topLeft: true,
                  topRight: true,
                  color: Colorize.white,
                  children: [
                    const Spacer(flex: 2),
                    Text("Sign-in", style: Styles.HeaderLargeText(Colorize.SecondColor)),
                    const Spacer(flex: 2),
                    FillTextField(ctrl: _emailController, hint: "Enter Your Email"),
                    FillTextField(
                      ctrl: _passwordController,
                      hint: "Enter Your Password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    Button(
                      text: "Sign in",
                      onpressed: _handleLogin,
                      width: 250,
                    ),
                    const SizedBox(height: 7),
                    const HaveAnAccount(
                        text: "Don't have an account?",
                        buttontext: "Signup",
                        navigate: Signup()),
                    const Spacer(flex: 9),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
