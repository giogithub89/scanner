import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

Future<String> pickImage({ImageSource? source}) async {
  final picker = ImagePicker();

  String path = '';

  try {
    final getImage = await picker.pickImage(source: source!);
    if (getImage != null) {
      path = getImage.path;
    } else {
      debugPrint('no image path');
      path = '';
    }
  } catch (e) {
    log(e.toString());
  }
  return path;
}