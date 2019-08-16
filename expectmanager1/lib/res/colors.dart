import 'package:flutter/material.dart';

class Colours {
  static const Color app_main = Color(0xFF666666); //#666666

  static const Color transparent_80 = Color(0x80000000); //<!--204-->

  static const Color text_dark = Color(0xFF333333);
  static const Color text_normal = Color(0xFF666666);
  static const Color text_gray = Color(0xFF999999);
  static const Color text_border = Color(0xFF999999);
  static const Color background_color = Color(0xFFF2F2F2);
  static const Color background_color2 = Color(0xFFE6E6E6);
  static const Color text_placehold = Color(0xFF999999);
  static const Color text_placehold2 = Color(0xFF666666);
  static const Color text_lable = Color(0xFF212121);
  static const Color text_input = Color(0xFF121212);
  static const Color line_color = Color(0xFFE9E9E9);
  static const Color clear_color = Color(0x00000000);
  static const Color white_color = Color(0xFFFFFFFF);
  static const Color black_color = Color(0xFF000000);
  static const Color orange_color = Color(0xFFFFB54C);
  static const Color red_color = Color(0xFFFF1919);
  static const Color divider_color = Color(0xffe5e5e5);

  static const Color blue_color = Color(0xFF0DAEFF);
  static const Color capital_color = Color(0xFFFF9B1A);

  static const Color gray_33 = Color(0xFF333333); //51
  static const Color gray_66 = Color(0xFF666666); //102
  static const Color gray_99 = Color(0xFF999999); //153
  static const Color common_orange = Color(0XFFFC9153); //252 145 83
  static const Color gray_ef = Color(0XFFEFEFEF); //153

  static const Color gray_f0 = Color(0xfff0f0f0); //<!--204-->
  static const Color gray_f5 = Color(0xfff5f5f5); //<!--204-->
  static const Color gray_cc = Color(0xffcccccc); //<!--204-->
  static const Color gray_ce = Color(0xffcecece); //<!--206-->
  static const Color gray_21 = Color(0xff212121);
  static const Color gray_e6 = Color(0xffe6e6e6);

  static const Color green_1 = Color(0xff009688); //<!--204-->
  static const Color green_62 = Color(0xff626262); //<!--204-->
  static const Color green_e5 = Color(0xffe5e5e5); //<!--204-->

  static const Color orange_72 = Color(0xffff7200);
  static const Color bottom_line = Color(0xffe5e5e5);
  static const Color blue_bg = Color(0xff29166F);
  static const Color background_f2 = Color(0xfff2f2f2);
}

class FontWeights {
  static const FontWeight medium = FontWeight.w400;
  static const FontWeight bold = FontWeight.w700;
}

Map<String, Color> themeColorMap = {
  'usercolor': Colours.blue_color,
  'managercolor': Color(0xFFFF7200),
  'capitalcolor': Color(0xFFFF9B1A),
};

class ImgPrefix {
  static const manager_prefix = 'assets/images/manager/';
}
