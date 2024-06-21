import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recommend_book_app/provider/book_provider.dart';
import 'package:recommend_book_app/utils/colors.dart';
import 'package:recommend_book_app/utils/images.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _modalBottomSheetMenu(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(),
          Text(
            "${authProvider.authModel.username}",
            style: GoogleFonts.inter(
              fontSize: 17.sp,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                Images.user,
                color: Colors.black,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Personal info',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          CustomTextFormFiled(
              labelText: "Username",
              initText: "${authProvider.authModel.username}"),
          CustomTextFormFiled(
              labelText: "Email", initText: "${authProvider.authModel.email}"),
        ],
      ),
    );
  }
}

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.initText,
    required this.labelText,
  });
  final String initText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(10.r)),
        child: TextFormField(
          initialValue: initText,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              label: Text(labelText),
              labelStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }
}

void _modalBottomSheetMenu(BuildContext context) {
  final authProvider = Provider.of<BookProvider>(context, listen: false);
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return Container(
          height: 265.h,
          decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                    child: Text(
                  // 'Are you sure you want to logout?',
                  "Are you sure you want to logout?",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Manrope',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: const Center(
                      child: Text(
                        'No, stay connected',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                GestureDetector(
                  onTap: () {
                    authProvider.logoutUser(context);
                  },
                  child: Container(
                    height: 55.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: const Center(
                      child: Text(
                        'Yes, disconnect',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        );
      });
}
