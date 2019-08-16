import 'dart:math';

import '../../../common/component_index.dart';

class MyPainter extends CustomPainter {
  MyPainter.dottingArc(
    this.grade,
    this.paintType,
  );

  int paintType = 0;
  num grade;
  Paint _paint = Paint()
    ..color = Colours.white_color //画笔颜色
    ..strokeCap = StrokeCap.butt //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 20 //画笔的宽度
    ..style = PaintingStyle.stroke; //画笔样式，默认为填充;

  Paint _paint2 = Paint()
    ..color = Color(0xFF4F8CFE) //画笔颜色
    ..strokeCap = StrokeCap.butt //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 20 //画笔的宽度
    ..style = PaintingStyle.stroke; //画笔样式，默认为填充

  Paint _paint3 = Paint()
    ..color = Colours.background_color2 //画笔颜色
    ..strokeCap = StrokeCap.butt //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 20 //画笔的宽度
    ..style = PaintingStyle.stroke; //画笔样式，默认为填充;

  Paint _paint4 = Paint()
    ..color = Colours.blue_color //画笔颜色
    ..strokeCap = StrokeCap.butt //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 20 //画笔的宽度
    ..style = PaintingStyle.stroke; //画笔样式，默认为填充;

  Paint _paint5 = Paint()
    ..color = Colours.background_color2 //画笔颜色
    ..strokeCap = StrokeCap.butt //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 15 //画笔的宽度
    ..style = PaintingStyle.stroke; //画笔样式，默认为填充;

  Paint _paint6 = Paint()
    ..color = Colours.blue_color //画笔颜色
    ..strokeCap = StrokeCap.butt //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..strokeWidth = 15 //画笔的宽度
    ..style = PaintingStyle.stroke; //画笔样式，默认为填充;

  @override
  void paint(Canvas canvas, Size size) {
    // 画个实心圆

    // canvas.drawOval(Rect.fromLTWH(15, 15, 120, 91), _paint);

    if (paintType == 1) {
      for (int i = 0; i < 25; i++) {
        canvas.drawArc(
            new Rect.fromLTWH(10, 10, 135, 135),
            3 / 4 * pi + 4 / 100 * i * 6 / 4 * pi,
            6 / 4 * pi / 100,
            false,
            _paint2);
      }

      int gradeInt = this.grade.toInt();
      int lineCount = gradeInt ~/ 4;
      for (int i = 0; i < lineCount; i++) {
        canvas.drawArc(
            new Rect.fromLTWH(10, 10, 135, 135),
            3 / 4 * pi + 4 / 100 * i * 6 / 4 * pi,
            6 / 4 * pi / 100,
            false,
            _paint);
      }
    } else if (paintType == 2) {
      double gradeDouble = this.grade.toDouble();
      // canvas.drawCircle(Offset(77.5, 77.5), 65, _paint3);
      canvas.drawArc(
          new Rect.fromLTWH(10, 10, 135, 135), 0, 2 * pi, false, _paint3);
      canvas.drawArc(new Rect.fromLTWH(10, 10, 135, 135), 0,
          gradeDouble / 100 * 2 * pi, false, _paint4);
    } else if (paintType == 3) {
      double gradeDouble = this.grade.toDouble();
      canvas.drawArc(
          new Rect.fromLTWH(5.5, 5.2, 85, 85), 0, 2 * pi, false, _paint5);
      canvas.drawArc(new Rect.fromLTWH(5.5, 5.2, 85, 85), 0,
          gradeDouble / 100 * 2 * pi, false, _paint6);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
