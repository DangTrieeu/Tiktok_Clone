import 'package:flutter/material.dart';
import 'package:tiktok_clone/widgets/like_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  final List<Color> colors = [
    Colors.cyanAccent,
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

            Container(color: color),

            Positioned(
              right: 16,
              bottom: 32,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=${index + 1}',
                    ),
                  ),
                  SizedBox(height: 20),

                  // Column(
                  //   children: [
                  //     Icon(Icons.favorite, size: 40, color: Colors.white),
                  //     Text("120k", style: TextStyle(color: Colors.white)),
                  //   ],
                  // ),
                  // SizedBox(height: 20),

                  LikeButton(initialCount: 120, isLiked: false),
                  SizedBox(height: 20),


                  Column(
                    children: [
                      Icon(Icons.comment, size: 40, color: Colors.white),
                      Text("3400", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 20),

                  Column(
                    children: [
                      Icon(Icons.share, size: 40, color: Colors.white),
                      Text("Share", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
