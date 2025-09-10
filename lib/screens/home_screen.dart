import 'package:flutter/material.dart';
import 'package:tiktok_clone/videos/video_player.dart';
import 'package:tiktok_clone/widgets/comment_sheet.dart';
import 'package:tiktok_clone/widgets/like_button.dart';
import 'package:gap/gap.dart';
import 'package:tiktok_clone/models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  // Danh sách các video assets
  final List<String> videoAssets = [
    'assets/videos/1.mp4',
    'assets/videos/2.mp4',
    'assets/videos/3.mp4',
    'assets/videos/4.mp4',
  ];

  // Danh sách các Post
  late List<Post> posts;

  @override
  void initState() {
    super.initState();
    posts = List.generate(videoAssets.length, (index) => Post(
      id: 'post_$index',
      videoUrl: videoAssets[index],
      user: '@user$index',
      caption: 'Video số ${index + 1} - caption mẫu',
      likeCount: 120 + index * 10,
      commentCount: 3400 + index * 100,
    ));
  }

  void handleLike(int postIndex) {
    setState(() {
      final post = posts[postIndex];
      post.likeCount += 1;
    });
  }

  void handleUnlike(int postIndex) {
    setState(() {
      final post = posts[postIndex];
      if (post.likeCount > 0) post.likeCount -= 1;
    });
  }

  void handleAddComment(int postIndex, String comment) {
    setState(() {
      posts[postIndex].commentCount += 1;
    });
    // Có thể thêm logic lưu comment nếu cần
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Stack(
          children: [
            VideoPlayerItem(videoUrl: post.videoUrl),
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
                  LikeButton(
                    initialCount: post.likeCount,
                    isLiked: false,
                    onChanged: (isLiked) {
                      if (isLiked) {
                        handleLike(index);
                      } else {
                        handleUnlike(index);
                      }
                    },
                  ),
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
                              onAddComment: (comment) => handleAddComment(index, comment),
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
