import 'package:flutter/material.dart';
import 'package:tiktok_clone/videos/video_player.dart';
import 'package:tiktok_clone/widgets/comment_sheet.dart';
import 'package:tiktok_clone/widgets/like_button.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  final List<Color> colors = [
    Colors.grey,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final color = colors[index % colors.length];
        return Stack(
          children: [
            //Container(color: color),
            
            VideoPlayerItem(videoUrl: "assets/videos/1.mp4"),

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

                  LikeButton(initialCount: 120, isLiked: false),

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
                          final screenHeight = MediaQuery
                              .of(context)
                              .size
                              .height;
                          return SizedBox(
                            height: screenHeight * 0.5,
                            child: CommentSheet(),
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Icon(Icons.comment, size: 40, color: Colors.white),
                        Text("3400", style: TextStyle(color: Colors.white)),
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
                      "@username",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "This is a description of the video. #hashtag",
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
                )
            )
          ],
        );
      },
    );
  }
}
