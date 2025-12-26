import 'package:chat_app/Behaviour/Constants/colors_constants.dart';
import 'package:chat_app/Behaviour/Constants/utilies.dart';
import 'package:chat_app/Behaviour/Constants/validation.dart';
import 'package:chat_app/presentation/Views/Authentication/sign_up.dart';
import 'package:chat_app/presentation/Views/Chat/chat_page.dart';
import 'package:chat_app/presentation/Widgets/build_elevated_button.dart';
import 'package:chat_app/presentation/Widgets/build_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static const String id = "SignIn";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email, password;
  bool isLoaded = false;
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: ModalProgressHUD(
        inAsyncCall: isLoaded,
        child: Scaffold(
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
                        validator: (data) {
                          return Validation.emailValidation(data);
                        },
                        bordersColor: ColorsConstants.kWhite,
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
                        bordersColor: ColorsConstants.kWhite,
                      ),
                      SizedBox(height: 35),
                      BuildElevatedButton(
                        textOfElevatedButton: "Sign In",
                        onPressed: () async {
                          if (globalKey.currentState!.validate()) {
                            isLoaded = true;
                            setState(() {});
                            try {
                              await signingInUser();
                              Navigator.pushNamed(context, ChatPage.id);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                Utilies.showSnackBar(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  message: 'User Not Found',
                                );
                              } else if (e.code == 'wrong-password') {
                                Utilies.showSnackBar(
                                  // ignore: use_build_context_synchronously
                                  context: context,
                                  message: 'Wrong Password',
                                );
                              }
                            }
                          }
                          isLoaded = false;
                          setState(() {});
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
        ),
      ),
    );
  }

  Future<void> signingInUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
