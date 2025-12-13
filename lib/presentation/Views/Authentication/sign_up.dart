import 'package:chat_app/Behaviour/Constants/colors_constants.dart';
import 'package:chat_app/presentation/Widgets/build_elevated_button.dart';
import 'package:chat_app/presentation/Widgets/build_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  static const String id = "SignUp";
  String? email, password;
  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.kPrimaryColor,
      body: Form(
        key: globalKey,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(height: 80),
                  Image.asset("assets/images/scholar_chat_app_icon.webp"),
                  SizedBox(height: 25),
                  Text(
                    "Scholar Chat",
                    style: GoogleFonts.pacifico(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 15),
                    BuildTextFormField(
                      labelText: "Email",
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (data) {
                        return emailValidation(data);
                      },
                    ),
                    SizedBox(height: 15),
                    BuildTextFormField(
                      labelText: "Password",
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (data) {
                        return passwordValidation(data);
                      },
                    ),
                    SizedBox(height: 35),
                    BuildElevatedButton(
                      textOfElevatedButton: "Sign Up",
                      onPressed: () async {
                        if (globalKey.currentState!.validate()) {
                          try {
                            await signingUpUser();
                            showSnackBar(context: context, message: "Success");
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackBar(
                                context: context,
                                message: "Weak Password",
                              );
                            } else if (e.code == 'email-already-in-use') {
                              showSnackBar(
                                context: context,
                                message: "Email Already In Use",
                              );
                            }
                          }
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            " Sign In",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? emailValidation(String? data) {
    if (data == null || data.isEmpty)
      return "Email is required";
    else if (!isValidEmail(data)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? passwordValidation(String? data) {
    if (data == null || data.isEmpty) {
      return "Password is required";
    } else if (!isValidPassword(data)) {
      return "Enter a valid password";
    }
    return null;
  }

  Future<void> signingUpUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }

  void showSnackBar({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool isValidPassword(String password) {
    return RegExp(
      r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,20}$",
    ).hasMatch(password);
  }

  bool isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$",
    ).hasMatch(email);
  }
}
