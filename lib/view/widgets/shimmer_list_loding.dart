
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Shimmer_list_loding extends StatelessWidget {
  const Shimmer_list_loding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
            height: 80.h,
            width: double.infinity,
            child: Center(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 40.w,
                              width: 40.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 30.w,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10)),
                                    ),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Container(
                                      width: 50.w,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 30.w,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10)),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Container(
                                      width: 10.w,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10)),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Container(
                                      width: 20.w,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(
                                                  10)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      const Divider(
                        color: Colors.black,
                      )
                    ],
                  );
                },
              ),
            )),
      );
  }
}
