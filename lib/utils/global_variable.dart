import 'package:flutter/material.dart';

const webScreenSize = 600;

nextPage(context, toPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => toPage));
}
nextPageReplacement(context, toPage) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => toPage));
}

previousPage(context) {
  Navigator.pop(context);
}
