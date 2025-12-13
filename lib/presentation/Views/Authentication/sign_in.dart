import 'package:chat_app/Behaviour/Constants/colors_constants.dart';
import 'package:chat_app/presentation/Views/Authentication/sign_up.dart';
import 'package:chat_app/presentation/Widgets/build_elevated_button.dart';
import 'package:chat_app/presentation/Widgets/build_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  static const String id = "SignIn";
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.kPrimaryColor,
      body: Column(
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
                      "Sign In",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  BuildTextFormField(
                    labelText: "Email",
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 15),
                  BuildTextFormField(
                    labelText: "Password",
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 35),
                  BuildElevatedButton(
                    textOfElevatedButton: "Sign In",
                    onPressed: () async {
                      var auth = FirebaseAuth.instance;
                      UserCredential user = await auth
                          .signInWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don't have an account ?",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignUp.id);
                        },
                        child: Text(
                          " Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }
}
