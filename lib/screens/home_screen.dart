import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/videos/video_player.dart';
import 'package:tiktok_clone/widgets/comment_sheet.dart';
import 'package:tiktok_clone/widgets/like_button.dart';
import 'package:gap/gap.dart';
import 'package:tiktok_clone/models/post_provider.dart';

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final posts = postProvider.posts;
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Stack(
          children: [
            VideoPlayerItem(videoUrl: post.videoUrl, postIndex: index),
            Positioned(
              right: 16,
              bottom: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=${index + 1}',
                    ),
                  ),
                  LikeButton(postIndex: index),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          final screenHeight = MediaQuery.of(context).size.height;
                          return SizedBox(
                            height: screenHeight * 0.5,
                            child: CommentSheet(
                              postIndex: index,
                              commentCount: post.commentCount,
                              onAddComment: (comment) => postProvider.addComment(index, comment),
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.comment, size: 40, color: Colors.white),
                        Text("${post.commentCount}", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(Icons.share, size: 40, color: Colors.white),
                      Text("Share", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ].expand((widget) => [widget, Gap(20)]).toList(),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    post.caption,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.music_note, color: Colors.white, size: 16),
                      SizedBox(width: 5),
                      Text(
                        "Original Sound - Artist Name",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
