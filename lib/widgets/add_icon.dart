import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/utils.dart';

class CustomAddIcon extends StatelessWidget {
  final bool isUpload;
  const CustomAddIcon({
    super.key,
    required this.isUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isUpload ? 1 : 0.6,
      child: Container(
        height: 27.0,
        width: 27.0,
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: const Icon(
          Icons.add,
          color: mobileSearchColor,
        ),
      ),
    );
  }
}
