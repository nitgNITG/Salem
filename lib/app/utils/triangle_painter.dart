import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../core/themes/colors.dart';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the triangle
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);

    path.lineTo(
      size.width / 2,
      size.height,
    );
    path.close();
    // Set the paint color to red
    Paint paint = Paint()..color = const Color(0xffAE8200);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.7);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.8,
    );
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/*
//Add this CustomPaint widget to the Widget Tree
CustomPaint(
    size = Size(400, (400*1.218918918918919).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
    painter = RPSCustomPainter(),
)
 */
//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  RPSCustomPainter(this.context);
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.2815965);
    path_0.cubicTo(
      0,
      size.height * 0.1836302,
      size.width * 0.09680324,
      size.height * 0.1042129,
      size.width * 0.2162162,
      size.height * 0.1042129,
    );
    path_0.lineTo(size.width * 0.8134243, size.height * 0.1042129);
    path_0.cubicTo(
        size.width * 0.8897946,
        size.height * 0.1042129,
        size.width * 0.9605865,
        size.height * 0.07140222,
        size.width,
        size.height * 0.01773836);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.2815965);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.03513541, size.height * 0.02993326),
        Offset(size.width * 0.5077676, size.height * 1.168339),
        [kPrimaryColor, kSecondaryColor],
        [0, 0.774211]);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
