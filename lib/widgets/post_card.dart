import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/database/firestore_methods.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import '../utils/utils.dart';

class PostCard extends StatefulWidget {
  final QueryDocumentSnapshot snap;
  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final Timestamp _time = widget.snap['datePublished'];
    final DateTime _dateTime = DateTime.parse(_time.toDate().toString());
    final User user = context.read<UserProvider>().getUser;

    bool isLikeAnimating = false;

    Widget bottomDetailsSheet() {
      return Scaffold(
        bottomNavigationBar: const Row(
          children: [],
        ),
        body: DraggableScrollableSheet(
          initialChildSize: .5,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return ListView(
              controller: scrollController,
              children: const [
                ListTile(
                  title: Text(
                    "Comments",
                  ),
                )
              ],
            );
          },
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage(
                  widget.snap['profileImage'],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  widget.snap['username'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            FirestoreMethods().likePost(
              widget.snap['postId'].toString(),
              user.uid,
              widget.snap['likes'],
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Image.network(
                  widget.snap['postUrl'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                icon: widget.snap['likes'].contains(user.uid)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      ),
                onPressed: () async {
                  await FirestoreMethods().likePost(
                    widget.snap['postId'],
                    user.uid,
                    widget.snap['likes'],
                  );
                }),
            IconButton(
              onPressed: () => showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                backgroundColor: mobileBackgroundColor,
                context: context,
                builder: (context) => bottomDetailsSheet(),
              ),
              icon: const Icon(
                Icons.comment,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.send,
              ),
            ),
            Expanded(
              child: IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_outline,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${widget.snap['likes'].length} likes',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${widget.snap['username']} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: widget.snap['description'],
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 3.0,
              ),
              InkWell(
                onTap: () => showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  backgroundColor: mobileBackgroundColor,
                  context: context,
                  builder: (context) => bottomDetailsSheet(),
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'view all 133 comments',
                    style: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  timeago.format(_dateTime),
                  style: const TextStyle(
                    color: secondaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
