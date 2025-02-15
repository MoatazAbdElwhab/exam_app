// core/resources/style_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
) =>
    TextStyle(
      fontSize: fontSize,
      fontFamily: 'Inter',
      color: color,
      fontWeight: fontWeight,
    );

TextStyle getLightStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12.sp,
      FontWeight.w300,
      color,
    );

TextStyle getRegularStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12.sp,
      FontWeight.w400,
      color,
    );

TextStyle getMediumStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12.sp,
      FontWeight.w500,
      color,
    );

TextStyle getSemiBoldStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12.sp,
      FontWeight.w600,
      color,
    );

TextStyle getBoldStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12.sp,
      FontWeight.w700,
      color,
    );
TextStyle getTextUnderLine({
  double? fontSize,
  required Color color,
}) =>
    TextStyle(
      color: color,
      fontSize: fontSize ?? 12.sp,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
      decorationColor: color,
    );