import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/global_variable.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget MobileLayout;
  final Widget WebLayout;

  const ResponsiveLayout({
    required this.MobileLayout,
    required this.WebLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < webScreenSize) {
        return MobileLayout;
      } else {
        return WebLayout;
      }
    });
  }
}
