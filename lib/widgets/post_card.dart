import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../utils/utils.dart';

class PostCard extends StatelessWidget {
  final QueryDocumentSnapshot snap;
  const PostCard({
    super.key,
    required this.snap,
  });

  @override
  Widget build(BuildContext context) {
    Timestamp _time = snap['datePublished'];
    DateTime dateTime = DateTime.parse(_time.toDate().toString());
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
                  snap['profileImage'],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  snap['username'],
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
        AspectRatio(
          aspectRatio: 10 / 8,
          child: CachedNetworkImage(
            imageUrl: snap['postUrl'],
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: secondaryColor,
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
              ),
            ),
            IconButton(
              onPressed: () {},
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
                alignment: Alignment.bottomRight,
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
            '${snap['likes'].length} likes',
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
                      text: "${snap['username']} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: snap['description'],
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
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  'view all 133 comments',
                  style: TextStyle(
                    color: secondaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  timeago.format(dateTime),
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
