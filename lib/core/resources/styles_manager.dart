import 'package:flutter/material.dart';

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
      fontSize ?? 12,
      FontWeight.w300,
      color,
    );

TextStyle getRegularStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12,
      FontWeight.w400,
      color,
    );

TextStyle getMediumStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12,
      FontWeight.w500,
      color,
    );

TextStyle getSemiBoldStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12,
      FontWeight.w600,
      color,
    );

TextStyle getBoldStyle({
  double? fontSize,
  required Color color,
}) =>
    _getTextStyle(
      fontSize ?? 12,
      FontWeight.w700,
      color,
    );
