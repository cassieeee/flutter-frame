import 'package:flutter/material.dart';
///  自定义 密码输入框 第一步 —— 使用画笔画出单个的框
class CustomJPasswordField extends StatelessWidget {
  ///  传入当前密码
  String data;
  CustomJPasswordField({Key key, @required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyCustom(data),
    );
  }
}

///  继承CustomPainter ，来实现自定义图形绘制
class MyCustom extends CustomPainter {
  ///  传入的密码，通过其长度来绘制圆点
  String pwdLength;
  MyCustom(this.pwdLength);

  ///  此处Sizes是指使用该类的父布局大小
  @override
  void paint(Canvas canvas, Size size) {
    // 密码画笔
    Paint mPwdPaint;
    Paint mRectPaint;

    // 初始化密码画笔
    mPwdPaint = new Paint();
    mPwdPaint..color = Colors.black;

//   mPwdPaint.setAntiAlias(true);
    // 初始化密码框
    mRectPaint = new Paint();
    mRectPaint..color = Color(0xFFA0A0A0);

    ///  圆角矩形的绘制
    RRect r = new RRect.fromLTRBR(
        0.0, 0.0, size.width, size.height, new Radius.circular(5));

    ///  画笔的风格
    mRectPaint.style = PaintingStyle.stroke;
    canvas.drawRRect(r, mRectPaint);

    ///  将其分成六个 格子（六位支付密码）
    var per = size.width / 6.0;
    var offsetX = per;
    while (offsetX < size.width) {
      canvas.drawLine(new Offset(offsetX, 0.0),
          new Offset(offsetX, size.height), mRectPaint);
      offsetX += per;
    }

    ///  画实心圆
    var half = per / 2;
    var radio = per / 8;
    mPwdPaint.style = PaintingStyle.fill;

    ///  当前有几位密码，画几个实心圆
    for (int i = 0; i < pwdLength.length && i < 6; i++) {
      canvas.drawArc(
          new Rect.fromLTRB(i * per + half - radio, size.height / 2 - radio,
              i * per + half + radio, size.height / 2 + radio),
          0.0,
          30,
          true,
          mPwdPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}