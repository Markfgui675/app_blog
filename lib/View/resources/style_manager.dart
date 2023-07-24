import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, TextStyle fontStyle,Color color, FontWeight fontWeight){
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontStyle.toString(),
    color: color,
    fontWeight: fontWeight
  );
}

dynamic getAliceStyle({double fontSize = AppSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontManager.alice, color, FontWeight.w400);
}

dynamic getAlexandriaStyle({double fontSize = AppSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontManager.alexandria, color, FontWeight.w600);
}
