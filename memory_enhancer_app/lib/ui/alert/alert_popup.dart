import 'package:flutter/material.dart';
import 'package:memory_enhancer_app/app/themes/light_theme.dart';

AlertDialog CustomAlertOneButton({String? title, required Widget content, required String actionOneText, required Function() actionOnePressed}) {
  return AlertDialog(
    title: title != null ? Text(title) : null,
    content: content,
    actions: [TextButton(
      child: Text(actionOneText,
          style: TextStyle(color: lightTheme.accentColor, fontWeight: FontWeight.bold, fontSize: 20)),
      onPressed: actionOnePressed,
    )],
  );
}

AlertDialog CustomAlertTwoButton({String? title, required Widget content,
  required String actionOneText, required Function() actionOnePressed,
  required String actionTwoText, required Function() actionTwoPressed}) {
  return AlertDialog(
    title: title != null ? Text(title) : null,
    content: content,
    actions: [
      TextButton(
        child: Text(actionOneText,
            style: TextStyle(color: lightTheme.accentColor, fontWeight: FontWeight.bold, fontSize: 20)),
        onPressed: actionOnePressed,
      ),
      TextButton(
        child: Text(actionTwoText,
            style: TextStyle(color: lightTheme.accentColor, fontWeight: FontWeight.bold, fontSize: 20)),
        onPressed: actionTwoPressed,
      )],
  );
}