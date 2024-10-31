import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog {
  static void modal(BuildContext context,
      {required void Function() onPressed, required String content, required String title,
      required String buttonText}){


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(content),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(buttonText),
              onPressed: () {
                onPressed.call();
              },
            )
          ],
        );
      },
    );

  }
}