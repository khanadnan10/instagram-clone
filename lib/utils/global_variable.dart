import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Dimension of different screen size

const webScreenSize = 600;

// Navigation through pages

nextPage(context, toPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => toPage));
}

nextPageReplacement(context, toPage) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => toPage));
}

previousPage(context) {
  Navigator.pop(context);
}

// Image picker

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return _file.readAsBytes();
  } else {
    debugPrint('********** File not selected! ***********');
  }
}

// snackbar

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1000),
      content: Text(text),
    ),
  );
}
