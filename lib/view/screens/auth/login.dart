import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recommend_book_app/helper/validation.dart';
import 'package:recommend_book_app/provider/book_provider.dart';
import 'package:recommend_book_app/utils/colors.dart';
import 'package:recommend_book_app/utils/images.dart';
import 'package:recommend_book_app/view/screens/auth/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late BookProvider bookProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize bookProvider here to avoid the error
    bookProvider = Provider.of<BookProvider>(context);
  }

  bool isObsPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(Images.authbackgroundImage, fit: BoxFit.fill),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    const Text(
                      "Welcome\nBack!",
                      style: TextStyle(
                          fontSize: 36,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    TextFormField(
                      controller: email,
                      validator: (value) => Validation.emailValidation(value),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.red), //<-- SEE HERE
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
                      validator: (value) =>
                          Validation.passwordValidation(value),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.red), //<-- SEE HERE
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
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const ForgotPassword(),
                        //   ),
                        // )
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Forgot Password?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 67,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BookProvider()
                              .login(context, email.text, password.text);
                        }

                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const BtnNavigationBar(),
                        //     ));
                      },
                      child: bookProvider.isAuthloading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: const Center(
                                child: Text(
                                  "Login",
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
                      height: 28,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        ),
                        child: const Text.rich(
                          TextSpan(
                              text: "Create An Account ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                color: Colors.grey,
                              ),
                              children: [
                                TextSpan(
                                    text: "Sign Up",
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
