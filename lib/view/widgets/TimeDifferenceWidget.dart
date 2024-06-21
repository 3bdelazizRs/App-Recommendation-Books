import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeDifferenceWidget extends StatelessWidget {
  final String createdAt;

  TimeDifferenceWidget({required this.createdAt});

  String getTimeDifference(String createdAt) {
    DateTime now = DateTime.now();
    DateTime createdDate = DateTime.parse(createdAt);
    Duration difference = now.difference(createdDate);

    if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getTimeDifference(createdAt),
      style: GoogleFonts.inter(
        fontSize: 10.sp,
        color: Colors.black.withOpacity(0.4),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
