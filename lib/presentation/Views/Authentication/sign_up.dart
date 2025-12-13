import 'package:chat_app/Behaviour/Constants/colors_constants.dart';
import 'package:chat_app/Behaviour/Constants/utilies.dart';
import 'package:chat_app/Behaviour/Constants/validation.dart';
import 'package:chat_app/presentation/Widgets/build_elevated_button.dart';
import 'package:chat_app/presentation/Widgets/build_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});
  static const String id = "SignUp";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email, password;
  bool isLoading = false;
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: ColorsConstants.white,
      child: Scaffold(
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
                          return Validation.emailValidation(data);
                        },
                      ),
                      SizedBox(height: 15),
                      BuildTextFormField(
                        labelText: "Password",
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (data) {
                          return Validation.passwordValidation(data);
                        },
                      ),
                      SizedBox(height: 35),
                      BuildElevatedButton(
                        textOfElevatedButton: "Sign Up",
                        onPressed: () async {
                          if (globalKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await signingUpUser();
                              Utilies.showSnackBar(
                                context: context,
                                message: "Success",
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                Utilies.showSnackBar(
                                  context: context,
                                  message: "Weak Password",
                                );
                              } else if (e.code == 'email-already-in-use') {
                                Utilies.showSnackBar(
                                  context: context,
                                  message: "Email Already In Use",
                                );
                              }
                            }
                            isLoading = false;
                            setState(() {});
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
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
        ),
      ),
    );
  }

  Future<void> signingUpUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
