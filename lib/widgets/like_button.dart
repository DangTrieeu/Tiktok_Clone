import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/models/post_provider.dart';

class LikeButton extends StatelessWidget {
  final int postIndex;
  const LikeButton({Key? key, required this.postIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final post = postProvider.posts[postIndex];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => postProvider.toggleLike(postIndex),
          icon: Icon(
            Icons.favorite,
            color: post.isLiked ? Colors.red : Colors.white,
            size: 35,
          ),
        ),
        Text(
          '${post.likeCount}',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
