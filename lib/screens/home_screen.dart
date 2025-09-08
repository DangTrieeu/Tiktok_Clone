import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final colors = [Colors.red, Colors.green, Colors.blue];
        final color = colors[index % colors.length];
        return Container(
          color: color,
          child: Center(
            child: Text(
              "Video ${index + 1}",
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          ),
        );
      },
    );

  }
}
