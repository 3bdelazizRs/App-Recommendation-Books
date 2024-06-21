import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recommend_book_app/provider/book_provider.dart';
import 'package:recommend_book_app/utils/colors.dart';
import 'package:recommend_book_app/utils/images.dart';
import 'package:recommend_book_app/view/screens/detailsbook_screen.dart';
import 'package:recommend_book_app/view/widgets/customimagenetwork.dart';

import '../../data/model/bookRecommendation/BookRecommendation.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<BookRecommendation>? recommendBook = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: Container(
              width: 339,
              height: 41,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(Images.search),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 19, left: 5),
                      child: TextFormField(
                        onFieldSubmitted: (book) async {
                          recommendBook =
                              await BookProvider().recommendBook(context, book);
                          log("List is : $recommendBook");
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Search by name..."),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: recommendBook == null
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 150.h),
                              child: SvgPicture.asset(
                                "assets/svg/nobookfound.svg",
                                width: 250,
                              ),
                            ),
                            Text(
                              "No Books Found",
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: greyColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text(
                              "There are no books available at the moment.",
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: grey1Color,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 20, // Changed to 20 for better spacing
                        crossAxisSpacing: 10, // Added crossAxisSpacing
                        childAspectRatio:
                            0.6, // Adjusted childAspectRatio for better layout
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsBook(
                                          bookTitle:
                                              recommendBook![index].title,
                                          bookauther:
                                              recommendBook![index].author,
                                          bookimage:
                                              recommendBook![index].imageUrl,
                                          isban: recommendBook![index].isbn,
                                        )),
                              );
                            },
                            // Added margin for better spacing
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    width: 107.w,
                                    height: 136.h,
                                    child: CustomNetworkImage(
                                        url: recommendBook![index].imageUrl)

                                    // Image.memory(
                                    //     recommendBook![index].imageBinary!)

                                    // MyImageWidget(
                                    //   imageUrl: recommendBook![index]
                                    //       .imageUrl,
                                    // ),
                                    ),
                                SizedBox(
                                    height: 8.h), // Added SizedBox for spacing
                                Text(
                                  recommendBook![index].author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: Colors.black.withOpacity(0.4),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                    height: 4.h), // Added SizedBox for spacing
                                Text(
                                  recommendBook![index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      itemCount: recommendBook!.length),
            ),
          ),
        ],
      ),
    );
  }
}
