import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recommend_book_app/helper/validation.dart';
import 'package:recommend_book_app/provider/book_provider.dart';
import 'package:recommend_book_app/utils/colors.dart';
import 'package:recommend_book_app/utils/images.dart';
import 'package:recommend_book_app/view/screens/auth/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isObsPassword = true;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(Images.authbackgroundImage, fit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 35),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create\naccount!",
                      style: TextStyle(
                          fontSize: 36,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    TextFormField(
                      validator: (val) => Validation.usernamValidation(val),
                      controller: username,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.grey), //<-- SEE HERE
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.red), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.grey), //<-- SEE HERE
                          ),
                          prefixIcon: const Icon(Icons.person_2),
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            color: Colors.grey,
                          ),
                          hintText: "Username"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: email,
                      validator: (val) => Validation.emailValidation(val),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.grey), //<-- SEE HERE
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.red), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.grey), //<-- SEE HERE
                          ),
                          prefixIcon: const Icon(Icons.person_2),
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            color: Colors.grey,
                          ),
                          hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: isObsPassword,
                      validator: (val) => Validation.passwordValidation(val),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.red), //<-- SEE HERE
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

                            borderSide: const BorderSide(
                                color: Colors.grey), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.grey), //<-- SEE HERE
                          ),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                              onTap: () => setState(() {
                                    isObsPassword = !isObsPassword;
                                  }),
                              child: Icon(isObsPassword
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_moderator_outlined)),
                          hintStyle: const TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            color: Colors.grey,
                          ),
                          hintText: "Password"),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    const SizedBox(
                      height: 67,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          bookProvider.register(
                              context,
                              username.text,
                              email.text,
                              password.text);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Center(
                          child: Text(
                            "Create account",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        ),
                        child: const Text.rich(
                          TextSpan(
                              text: "Already have an account ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                    text: "Log in",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.grey,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      color: Colors.grey,
                                    ))
                              ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
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
