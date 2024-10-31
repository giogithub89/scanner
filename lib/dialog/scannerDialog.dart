import 'package:flutter/material.dart';


class ScannerDialog extends StatefulWidget {
  final Function(int?)? onPressed;
  final int? index;

  const ScannerDialog({Key? key, this.onPressed, this.index}) : super(key: key);
  @override
  State<ScannerDialog> createState() => _ScannerDialogState();
}

class _ScannerDialogState extends State<ScannerDialog> {

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  widget.onPressed?.call(1);
                },
                child: Text(
                  'add by scan'.toUpperCase(),
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  widget.onPressed?.call(2);
                },
                child: Text(
                  'Open gallery'.toUpperCase(),
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(
              height: 1,
            ),
            SizedBox( width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'cancel',
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      );
  }
}