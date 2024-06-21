import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommend_book_app/data/model/auth_model/auth_model.dart';
import 'package:recommend_book_app/provider/book_provider.dart';
import 'package:recommend_book_app/utils/colors.dart';
import 'package:recommend_book_app/utils/images.dart';
import 'package:recommend_book_app/view/screens/auth/login.dart';
import 'package:recommend_book_app/view/screens/navigation_bar.dart';

import '../../data/db/shared-preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _leftAnimationController;
  late AnimationController _rightAnimationController;
  late Animation<double> _leftAnimation;
  late Animation<double> _rightAnimation;
  @override
  void initState() {
    routes();
    super.initState();
    // Left container animation
    _leftAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _leftAnimation = Tween<double>(begin: -200.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _leftAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Right container animation
    _rightAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _rightAnimation = Tween<double>(begin: 200.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _rightAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations
    _leftAnimationController.forward();
    _rightAnimationController.forward();
  }

  @override
  void dispose() {
    _leftAnimationController.dispose();
    _rightAnimationController.dispose();
    super.dispose();
  }

  void routes() async {
    final authProvider = Provider.of<BookProvider>(context, listen: false);
    var user = await LocalDb.getUser();
    log("$user");
    Timer(const Duration(seconds: 3), () {
      if (user != null) {
        authProvider.authModel = Auth.fromJson(user);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BtnNavigationBar()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                Images.splashbackgroundImage,
                fit: BoxFit.fill,
              )),
          Column(
            children: [
              SizedBox(
                height: 270.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _leftAnimationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_leftAnimation.value, 0.0),
                        child: Center(
                          child: Text(
                            'B',
                            style: GoogleFonts.inter(
                              fontSize: 65.sp,
                              color: logoColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  SvgPicture.asset(Images.booklogo),
                  SizedBox(
                    width: 8.w,
                  ),
                  AnimatedBuilder(
                    animation: _rightAnimationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_rightAnimation.value, 0.0),
                        child: Center(
                            child: Text(
                          'K',
                          style: GoogleFonts.inter(
                            fontSize: 65.sp,
                            color: logoColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      );
                    },
                  ),
                ],
              ),
              Text(
                'Book Recommendations System',
                style: GoogleFonts.imFellGreatPrimerSc(
                  fontSize: 18.sp,
                  color: logoColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
