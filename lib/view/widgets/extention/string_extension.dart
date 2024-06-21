import 'package:flutter/material.dart';

extension StringExtension on String {
  Widget toText(
      {Color? color,
        double? fontSize,
        String? fontFamily,
        int? maxLine,
        TextAlign? textAlign,
        TextOverflow? overflow,
        FontWeight? fontWeight,
        bool? isBold,
        bool? isMedium}) =>
      Text(
        this,
        maxLines: maxLine ?? maxLine,
        textAlign: textAlign ?? textAlign,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 12,
          fontFamily: fontFamily,
          overflow: overflow ?? TextOverflow.ellipsis,
          fontWeight: fontWeight ??
              (isBold == true
                  ? FontWeight.bold
                  : (isMedium == true ? FontWeight.w500 : FontWeight.w400)),
        ),
      );
}
