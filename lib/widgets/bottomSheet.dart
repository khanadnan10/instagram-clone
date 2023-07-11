import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/comment_card.dart';

class BottomSheetModel extends StatelessWidget {
  const BottomSheetModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          // color: Colors.white,
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: const Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/Rog-Wallpaper.jpg'),
                radius: 18.0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add comment for {username}',
                        hintStyle: TextStyle(color: secondaryColor)),
                  ),
                ),
              ),
              Text(
                'Post',
                style: TextStyle(
                  color: blueColor,
                ),
              )
            ],
          ),
        ),
      ),
      body: DraggableScrollableSheet(
        initialChildSize: .5,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (BuildContext context, ScrollController scrollController) {
          return CommentCard();
        },
      ),
    );
  }
}
