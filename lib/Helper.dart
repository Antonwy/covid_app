import 'package:flutter/material.dart';

class Helper {
  static Color hexToColor(String hexCode) {
    hexCode = hexCode.toUpperCase().replaceAll("#", "");
    if (hexCode.length == 6) {
      hexCode = "FF" + hexCode;
    }
    return Color(int.parse(hexCode, radix: 16));
  }

  static double mapValue(n, start1, stop1, start2, stop2) {
    if (start1 == 0 && stop1 == 0) return 0;
    return ((n - start1) / (stop1 - start1)) * (stop2 - start2) + start2;
  }

  static Offset getPositionFromKey(GlobalKey key) {
    if (key.currentContext == null) return Offset(0, 0);

    final RenderBox renderBox = key.currentContext.findRenderObject();
    final pos = renderBox.localToGlobal(Offset.zero);

    return pos;
  }

  static Offset getCenteredPositionFromKey(GlobalKey key) {
    Offset pos = Helper.getPositionFromKey(key);
    Size size = Helper.getSizeFromKey(key);
    return Offset(pos.dx + size.width / 2, pos.dy + size.height / 2);
  }

  static Size getSizeFromKey(GlobalKey key) {
    if (key.currentContext == null) return null;

    final RenderBox containerRenderBox = key.currentContext.findRenderObject();
    return containerRenderBox.size;
  }

  static double getTextWidth(String text,
      {TextStyle style = const TextStyle()}) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr);
    textPainter.layout();
    return textPainter.width;
  }

  static String getDate(DateTime date) {
    return "${date.day < 10 ? "0${date.day}" : date.day}.${date.month < 10 ? "0${date.month}" : date.month}.${date.year}";
  }

  static showAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Error", style: TextStyle(color: Colors.red)),
              content: Text(
                message,
              ),
            ));
  }
}
